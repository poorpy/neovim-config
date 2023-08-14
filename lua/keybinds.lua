local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- set space as leader key
vim.g.mapleader = " "

-- user alt + hjkl to switch focused split
map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
map("i", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("i", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("i", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("i", "<C-l>", "<C-\\><C-N><C-w>l", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- use alt + shift + jk to swap tabs
map("t", "<A-J>", "<C-\\><C-N>gT", opts)
map("t", "<A-K>", "<C-\\><C-N>gt", opts)
map("i", "<A-J>", "<C-\\><C-N>gT", opts)
map("i", "<A-K>", "<C-\\><C-N>gt", opts)
map("n", "<A-J>", "gT", opts)
map("n", "<A-K>", "gt", opts)

-- use jj to return to normal mode
map("i", "jj", "<Esc>", opts)

-- disable search highlight after entering insert mode
for _, v in ipairs({ "a", "A", "<Insert>", "i", "I", "gI", "gi", "o", "O" }) do
    map("n", v, ":noh<CR>" .. v, opts)
end
