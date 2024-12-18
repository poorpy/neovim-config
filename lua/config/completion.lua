require "config.snippets"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
local cmp = require "cmp"

cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip", option = { use_show_condition = false } },
        { name = "path" },
        { name = "buffer" },
        { name = "lazydev", group_index = 0 },
    },
    mapping = {
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

        ["<Tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<S-Tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<CR>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),

        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
    },

    formatting = {
        format = lspkind.cmp_format {
            mode = "symbol_text",
        },
        expandable_indicator = true,
        fields = { "abbr", "kind", "menu" },
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    experimental = { ghost_text = { hl_group = "Comment" } },
}

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})
