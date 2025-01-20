return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = { library = { "luvit-meta/library" } },
            },

            { "j-hui/fidget.nvim", opts = {} },

            "saghen/blink.cmp",

            -- Autoformatting
            "stevearc/conform.nvim",

            -- Schema information
            "b0o/SchemaStore.nvim",
        },
        config = function()
            require("config.lsp").setup()
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
    },
}
