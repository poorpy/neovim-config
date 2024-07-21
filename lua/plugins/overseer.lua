return {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
        require("overseer").setup {
            templates = { "builtin", "user" },
        }
    end,
    keys = {
        {
            "<leader>ot",
            mode = { "n", "x", "o" },
            ":OverseerToggle<CR>",
            desc = "[O]verseer [T]oggle",
        },
        {
            "<leader>or",
            mode = { "n", "x", "o" },
            ":OverseerRun<CR>",
            desc = "[O]verseer [R]un",
        },
        {
            "<leader>oa",
            mode = { "n", "x", "o" },
            ":OverseerQuickAction<CR>",
            desc = "[O]verseer Quick [A]ction",
        },
    },
}
