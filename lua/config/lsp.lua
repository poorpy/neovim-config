local M = {}

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$")
            == nil
end

M.setup = function()
    local lsp = require("lsp-zero").preset({})

    lsp.on_attach(function(_, bufnr)
        local map = function(keys, func, desc)
            vim.keymap.set(
                "n",
                keys,
                func,
                { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc }
            )
        end

        local builtin = require("telescope.builtin")
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

    lsp.setup_servers({
        "texlab",
        "ccls",
        "dockerls",
        "rnix",
        "pyright",
        "zls",
        "ocamllsp",
    })

    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    -- rust_analyzer {{{
    require("lspconfig").rust_analyzer.setup({
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    })
    -- }}}

    -- gopls {{{
    require("lspconfig").gopls.setup({
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

    require("lspconfig").html.setup({
        init_options = {
            provideFormatter = false,
        },
    })

    require("lspconfig").jsonls.setup({
        cmd = { "json-languageserver", "--stdio" },
        init_options = {
            provideFormatter = false,
        },
    })

    local cmp = require("cmp")
    local cmp_action = require("lsp-zero").cmp_action()
    local lspkind = require("lspkind")

    local select_next_item = function(fallback)
        if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end

    local select_prev_item = function(fallback)
        if cmp.visible() and has_words_before() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end

    -- cmp setup {{{
    cmp.setup({
        sources = {
            { name = "copilot", group_index = 1 },
            { name = "nvim_lsp", group_index = 1 },
            { name = "nvim_lua", group_index = 1 },
            { name = "luasnip", keyword_length = 2, group_index = 1 },
            { name = "path", group_index = 2 },
            { name = "buffer", keyword_length = 3, group_index = 2 },
        },

        -- keymaps {{{
        mapping = {
            -- Open completion menu
            ["<C-Space>"] = cmp.mapping.complete(),

            -- Close completion menu
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),

            -- Select completion item
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),

            ["<Tab>"] = vim.schedule_wrap(select_next_item),
            ["<S-Tab>"] = vim.schedule_wrap(select_prev_item),
            ["<C-n>"] = vim.schedule_wrap(select_next_item),
            ["<C-p>"] = vim.schedule_wrap(select_prev_item),
            ["<Down>"] = vim.schedule_wrap(select_next_item),
            ["<Up>"] = vim.schedule_wrap(select_prev_item),

            -- Navigate between snippet placeholder
            ["<C-j>"] = cmp_action.luasnip_jump_forward(),
            ["<C-k>"] = cmp_action.luasnip_jump_backward(),

            -- Scroll docs up/down in preview
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        },
        -- }}}

        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol",
            }),
        },

        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },

        experimental = { native_menu = false, ghost_text = { hl_group = "Comment" } },
    })
    -- }}}

    -- {{{ snippets setup
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("handlebars", { "html" })
    -- }}}

    lsp.format_on_save({
        format_opts = {
            async = false,
            timeout_ms = 1000,
        },
        servers = {
            ["null-ls"] = { "lua", "typescript" },
        },
    })

    lsp.setup()

    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.formatting.prettier,
        },
    })
end

return M
