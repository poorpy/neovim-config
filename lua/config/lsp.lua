local M = {}

M.setup = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local lspconfig_defaults = require("lspconfig").util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
    )

    local servers = {
        "zls",
        "ccls",
        "nixd",
        "ruff",
        "templ",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "golangci_lint_ls",
    }

    local lspconfig = require "lspconfig"
    for _, server in ipairs(servers) do
        lspconfig[server].setup {}
    end

    -- rust_analyzer {{{
    require("lspconfig").rust_analyzer.setup {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    }
    -- }}}

    -- gopls {{{
    require("lspconfig").gopls.setup {
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
    }
    -- }}}

    require("lspconfig").tailwindcss.setup {
        cmd = { "npx", "@tailwindcss/language-server", "--stdio" },
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        settings = {
            tailwindCSS = {
                includeLanguages = {
                    templ = "html",
                },
            },
        },
    }

    require("lspconfig").html.setup {
        cmd = { "vscode-html-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },

        filetypes = { "html", "templ" },
    }

    require("lspconfig").jsonls.setup {
        cmd = { "vscode-json-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },
    }

    vim.lsp.set_log_level(vim.log.levels.DEBUG)

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
            map("gr", builtin.lsp_references, "[G]oto [R]eferences")
            map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
            map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
            map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
            map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            map("<leader>ce", vim.diagnostic.open_float, "[C]ode [E]rror")
            map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
            map("<leader><leader>", vim.lsp.buf.format, "[C]ode [F]ormat")
            map("K", vim.lsp.buf.hover, "Hover Documentation")
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            imap("<C-h>", vim.lsp.buf.signature_help, "Signature help")
        end,
    })
    -- }}}

    -- Autoformatting Setup
    require("conform").setup {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "golines" },
            zig = { "zigfmt" },
        },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
            require("conform").format {
                bufnr = args.buf,
                lsp_fallback = true,
                quiet = true,
            }
        end,
    })
end

return M
