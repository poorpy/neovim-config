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
        lsp.default_keymaps({
            buffer = bufnr,
            omit = { "K", "gr" },
        })

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
        vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    end)

    lsp.setup_servers({
        "rust_analyzer",
        "texlab",
        "ccls",
        "dockerls",
        "rnix",
        "pyright",
        "tsserver",
        "svelte",
    })

    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

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

    require("copilot_cmp").setup()

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
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.formatting.prettier,
        },
    })
end

return M
