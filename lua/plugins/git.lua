return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "[G]it" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "[G]it [B]lame" },
            { "<leader>gl", "<cmd>Git log<cr>", desc = "[G]it [L]og" },
            { "<leader>gc", "<cmd>Git commit<cr>", desc = "[G]it [C]ommit" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
