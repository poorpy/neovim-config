return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        { "Bilal2453/luvit-meta", lazy = true },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = { library = { "luvit-meta/library" } },
        },

        { "j-hui/fidget.nvim", opts = {} },

        "neovim/nvim-lspconfig",

        -- Autoformatting
        "stevearc/conform.nvim",

        -- Schema information
        "b0o/SchemaStore.nvim",
    },
    config = function()
        require("config.lsp").setup()
    end,
}
