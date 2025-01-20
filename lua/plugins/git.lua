return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "[G]it" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "[G]it [B]lame" },
            { "<leader>gl", "<cmd>Git log<cr>", desc = "[G]it [L]og" },
            { "<leader>gc", "<cmd>Git commit<cr>", desc = "[G]it [C]ommit" },
            { "<leader>gp", "<cmd>Git pull<cr>", desc = "[G]it [P]ull" },
            { "<leader>gP", "<cmd>Git push<cr>", desc = "[G]it [P]ush" },
        },
    },
}
