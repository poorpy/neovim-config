local M = {}

M.setup = function()
    local lsp = require "lsp-zero"

    lsp.setup_servers {
        "zls",
        "ccls",
        -- "clangd",
        "nixd",
        "ruff",
        "lua_ls",
        "pyright",
        "rust_analyzer",
    }

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

    require("lspconfig").html.setup {
        cmd = { "vscode-html-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },
    }

    require("lspconfig").jsonls.setup {
        cmd = { "vscode-json-language-server", "--stdio" },
        init_options = {
            provideFormatter = false,
        },
    }

    -- lsp attach {{{

    lsp.on_attach(function(_, bufnr)
        local map = function(keys, func, desc)
            vim.keymap.set(
                "n",
                keys,
                func,
                { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc }
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
    end)
    -- }}}

    -- Autoformatting Setup
    require("conform").setup {
        formatters_by_ft = {
            lua = { "stylua" },
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
