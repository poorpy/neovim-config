return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            keymap = {
                preset = "default",
                ["<C-j>"] = { "snippet_forward" },
                ["<C-k>"] = { "snippet_backward" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
            },

            completion = {
                accept = { auto_brackets = { enabled = true } },

                documentation = {
                    auto_show = true,
                    treesitter_highlighting = true,
                    window = { border = "rounded" },
                },

                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
                window = { border = "rounded" },
            },
        },
    },
}
