local map = function(modes, keys, func)
    vim.keymap.set(modes, keys, func, { noremap = true, silent = true })
end

-- use alt + shift + jk to swap tabs
map({ "i", "t" }, "<A-J>", "<C-\\><C-N>gT")
map({ "i", "t" }, "<A-K>", "<C-\\><C-N>gt")
map("n", "<A-J>", "gT")
map("n", "<A-K>", "gt")

-- disable search highlight after entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Clear search highlight",
    group = vim.api.nvim_create_augroup("NoHlsearch", { clear = true }),
    callback = function()
        vim.schedule(vim.cmd.nohlsearch)
    end,
})
