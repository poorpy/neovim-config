local present1, lspconfig = pcall(require, "lspconfig")
local present2, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not (present1 and present2) then
    return
end

local function custom_on_attach(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

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

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = cmp_lsp.default_capabilities(custom_capabilities)
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

local servers = {
    bashls = true,
    cssls = true,
    clangd = true,
    dockerls = true,
    golangci_lint_ls = true,
    html = { init_options = { provideFormatter = false } },
    jsonls = { init_options = { provideFormatter = false } },
    pyright = true,
    sumneko_lua = {
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = { "lua/?.lua", "lua/?/init.lua" },
                },
                completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
                diagnostics = {
                    enable = true,
                    globals = {
                        "vim",
                        "describe",
                        "it",
                        "before_each",
                        "after_each",
                        "teardown",
                        "pending",
                        "use",
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        },
    },
}

local setup_server = function(server, config)
    if not config then
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

for server, config in pairs(servers) do
    setup_server(server, config)
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

local function load_lsp()
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
            setup_server(split[#split], config)
        end
    end
end

load_lsp()

-- replace the default lsp diagnostic symbols
local function lsp_symbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lsp_symbol("Error", "")
lsp_symbol("Info", "")
lsp_symbol("Hint", "")
lsp_symbol("Warn", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        symbols = true,
    }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "single" }
)

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _)
    if msg:match("exit code") then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({ { msg } }, true, {})
    end
end
