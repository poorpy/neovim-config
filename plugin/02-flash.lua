vim.pack.add {
    "https://github.com/folke/flash.nvim",
}

local flash = require "flash"
vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
    flash.jump()
end, { noremap = true, silent = true, desc = "[F]lash [J]ump" })
