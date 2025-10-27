return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {},
        cmd = {
            "CopilotChat",
            "CopilotChatFix",
            "CopilotChatDocs",
            "CopilotChatExplain",
        },
        keys = {
            { "<leader>ccc", "<cmd>CopilotChat<cr>", desc = "[C]opilot [C]hat" },
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "[C]opilot [C]hat [E]xplain" },
            { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "[C]opilot [C]hat [D]ocs" },
            { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "[C]opilot [C]hat [F]ix" },
        },
    },
}
