-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- set tab to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- highlight cursorline
vim.o.cursorline = true

-- disable swap, backup, insert prompt
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.showmode = false

-- shorten status messages
vim.opt.shortmess:append("c")

-- set delay for autocmd events
vim.o.updatetime = 300

-- smart case matching in search
-- lowercase matches everyting
-- uppercase matches uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- hide buffer on closing
vim.o.hidden = true

-- mouse support
vim.o.mouse = "a"

-- completion options
vim.opt.completeopt = "menu"

-- always display signcolumn
vim.wo.signcolumn = "yes"

-- enable 24-bit RGB
vim.o.termguicolors = true

-- use dark background
vim.opt.background = "dark"

-- use nvr as git editor in terminal buffers
vim.env.GIT_EDITOR = "nvr -cc split --remote-wait"

-- use ripgrep instead of grep
vim.o.grepprg = "rg --vimgrep --smart-case --follow"

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "gitrebase", "gitconfig" },
    command = "set bufhidden=delete",
})
