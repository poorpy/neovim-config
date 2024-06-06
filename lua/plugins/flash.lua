return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>fj",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "[F]lash [J]ump",
        },
        {
            "<leader>ft",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "[F]lash [T]reesitter",
        },
    },
}
