local util_ok, util = pcall(require, "config.lsp.util")

if not util_ok then
    vim.notify("Failed to load lsp utils")
    return
end

local servers = {
    ansiblels = true,
    bashls = true,
    cssls = true,
    ccls = true,
    dockerls = true,
    golangci_lint_ls = true,
    html = { init_options = { provideFormatter = false } },
    jsonls = { init_options = { provideFormatter = false } },
    pyright = true,
    prosemd_lsp = true,
    texlab = { filetypes = { "tex", "plaintex", "bib", "latex" } },
    lua_ls = {
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

-- load lsp servers defined here
for server, config in pairs(servers) do
    util.setup_server(server, config)
end

-- load lsp servers defined in config.lsp.servers
util.load_lsp()

util.lsp_symbol("Error", "")
util.lsp_symbol("Info", "")
util.lsp_symbol("Hint", "")
util.lsp_symbol("Warn", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        symbols = true,
    })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

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
