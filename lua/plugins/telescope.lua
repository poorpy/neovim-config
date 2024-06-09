return {
    { "nvim-lua/plenary.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

            "nvim-telescope/telescope-smart-history.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "kkharji/sqlite.lua",
            "ThePrimeagen/harpoon",
        },
        branch = "0.1.x",
        config = function()
            require("config.telescope").setup()
        end,
    },
}
