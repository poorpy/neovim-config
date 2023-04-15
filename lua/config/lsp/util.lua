local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_lsp_ok then
    vim.notify("Failed to load cmp-nvim-lsp")
    return
end

if not lspconfig_ok then
    vim.notify("Failed to load lspconfig")
    return
end

---split string on all occurences of separator
---@param sep string
---@return table<string>
function string:split(sep)
    local separator, fields = sep or ",", {}
    local pattern = string.format("([^%s]+)", separator)
    _ = self:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

local M = {}

---replace the default lsp diagnostic symbols
---@param name string
---@param icon string
function M.lsp_symbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

local function custom_on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    client.server_capabilities.semanticTokensProvider = nil

    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
    buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "<leader><leader>", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
end

local custom_capabilities = cmp_lsp.default_capabilities()
custom_capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}
custom_capabilities.textDocument.colorProvider = {
    dynamicRegistration = true,
}

---setup lsp server with given config options
---@param server string server name
---@param config table|boolean
function M.setup_server(server, config)
    if not config then
        vim.notify("No config supplied for server: " .. server)
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_attach = custom_on_attach,
        capabilities = custom_capabilities,
        flags = { debounce_text_changes = 150 },
    }, config)

    lspconfig[server].setup(config)
end

---load configs for each server defined in config.lsp.servers
function M.load_lsp()
    local files = io.popen('find "$HOME/.config/nvim/lua/config/lsp/servers" -type f')
    if files == nil then
        return
    end

    for path in files:lines() do
        local file = path:gmatch("%/lua%/(.+).lua$")():gsub("/", ".")
        local ok, config = pcall(require, file)
        if not ok then
            vim.notify("Failed loading " .. file, vim.log.levels.ERROR)
        else
            local split = file:split(".")
            M.setup_server(split[#split], config)
        end
    end
end

return M
