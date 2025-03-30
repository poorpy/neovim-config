return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<CR>",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "[F]lash [J]ump",
        },
    },
}
