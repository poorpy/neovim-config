return {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup()
        require("which-key").add {
            { "<leader>c", group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>d_", hidden = true },
            { "<leader>f", group = "[F]lash" },
            { "<leader>f_", hidden = true },
            { "<leader>g", group = "[G]it" },
            { "<leader>g_", hidden = true },
            { "<leader>l", group = "[L]SP" },
            { "<leader>l_", hidden = true },
            { "<leader>r", group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>w_", hidden = true },
        }
    end,
}
