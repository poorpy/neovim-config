local map = function(modes, keys, func)
    vim.keymap.set(modes, keys, func, { noremap = true, silent = true })
end

-- use alt + shift + jk to swap tabs
map({ "i", "t" }, "<A-J>", "<C-\\><C-N>gT")
map({ "i", "t" }, "<A-K>", "<C-\\><C-N>gt")
map("n", "<A-J>", "gT")
map("n", "<A-K>", "gt")

-- use jj to return to normal mode
map("i", "jj", "<Esc>")

-- disable search highlight after entering insert mode
for _, v in ipairs { "a", "A", "<Insert>", "i", "I", "gI", "gi", "o", "O" } do
    map("n", v, ":noh<CR>" .. v)
end
