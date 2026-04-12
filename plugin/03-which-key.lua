vim.pack.add {
    "https://github.com/folke/which-key.nvim",
}

local key = require "which-key"
key.setup()
key.add {
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
