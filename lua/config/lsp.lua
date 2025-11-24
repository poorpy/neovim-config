local M = {}

M.setup = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local servers = {
        "zls",
        "ccls",
        "nixd",
        "ruff",
        "jdtls",
        "templ",
        "lua_ls",
        "terraformls",
        "rust_analyzer",
        "golangci_lint_ls",
    }

    vim.lsp.enable(servers)

    -- rust_analyzer {{{
    vim.lsp.config("rust_analyzer", {
        settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                },
                formatOnSave = true,
            },
        },
    })
    -- }}}

    -- gopls {{{
    vim.lsp.config("gopls", {
        cmd = { "gopls" },
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500,
        },
        settings = {
            gopls = {
                analyses = {
                    nilness = true,
                    unusewrites = true,
                    unusedparams = true,
                    unreachable = true,
                },
                codelenses = {
                    generate = true,
                    gc_details = true,
                    test = true,
                    tidy = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                matcher = "Fuzzy",
                diagnosticsDelay = "500ms",
                symbolMatcher = "fuzzy",
                gofumpt = true,
            },
        },
        filetypes = { "go", "gomod" },
    })
    -- }}}

    -- pyright {{{
    vim.lsp.config("pyright", {
        settings = {
            python = {
                analysis = {
                    diagnosticMode = "off",
                    typeCheckingMode = "off",
                },
            },
        },
    })
    -- }}}

    vim.lsp.config("tailwindcss", {
        cmd = { "npx", "@tailwindcss/language-server", "--stdio" },
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        settings = {
            tailwindCSS = {
                includeLanguages = {
                    templ = "html",
                },
            },
        },
    })

    -- html & json {{{
    vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },

        filetypes = { "html", "templ" },
    })

    vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },
    })
    -- }}}

    vim.lsp.set_log_level(vim.log.levels.ERROR)

    -- lsp attach {{{
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
            local map = function(keys, func, desc)
                vim.keymap.set(
                    "n",
                    keys,
                    func,
                    { buffer = event.buf, noremap = true, silent = true, desc = "LSP: " .. desc }
                )
            end
            local imap = function(keys, func, desc)
                vim.keymap.set(
                    "i",
                    keys,
                    func,
                    { buffer = event.buf, noremap = true, silent = true, desc = "LSP: " .. desc }
                )
            end

            local builtin = require "telescope.builtin"
            map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            map("gr", builtin.lsp_references, "[G]oto [R]eferences")
            map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
            map("gt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
            map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
            map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            map("<leader>ce", vim.diagnostic.open_float, "[C]ode [E]rror")
            map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
            map("<leader><leader>", vim.lsp.buf.format, "[C]ode [F]ormat")
            map("K", vim.lsp.buf.hover, "Hover Documentation")
            imap("<C-h>", vim.lsp.buf.signature_help, "Signature help")
        end,
    })
    -- }}}
end

return M
