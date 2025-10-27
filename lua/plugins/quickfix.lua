return {
    {
        "kevinhwang91/nvim-bqf",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            { "junegunn/fzf", version = "*" },
        },
        config = function()
            require("bqf").setup()
        end,
        ft = "qf",
    },
    {
        "stevearc/qf_helper.nvim",
        opts = {},
        keys = {
            { "<C-N>", mode = { "n", "x", "o" }, "<cmd>QNext<cr>" },
            { "<C-P>", mode = { "n", "x", "o" }, "<cmd>QPrev<cr>" },
            { "<leader>q", mode = { "n" }, "<cmd>QFToggle!<cr>" },
            { "<leader>l", mode = { "n" }, "<cmd>LLToggle!<cr>" },
        },
    },
}
