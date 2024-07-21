local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<localleader>r", ":!zig run %<CR>", opts)
