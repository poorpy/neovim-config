return {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup()
        require("which-key").add {
            { "<leader>c", group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>f", group = "[F]lash" },
            { "<leader>f_", hidden = true },
            { "<leader>g", group = "[G]it" },
            { "<leader>g_", hidden = true },
            { "<leader>r", group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>t_", hidden = true },
        }
    end,
}
