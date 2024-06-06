return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "FabijanZulj/blame.nvim",
        keys = {
            { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "[G]it [B]lame" },
        },
        config = function()
            require("blame").setup()
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        config = function()
            require("telescope").load_extension "lazygit"
        end,
    },
}
