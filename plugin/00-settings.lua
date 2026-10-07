-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- set tab to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- highlight cursorline
vim.o.cursorline = true

-- disable swap, backup; mode is shown by the statusline
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.showmode = false

-- shorten status messages
vim.opt.shortmess:append "Wc"

-- set delay for autocmd events
vim.o.updatetime = 300

-- smart case matching in search
-- lowercase matches everyting
-- uppercase matches uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- show preview of s/smagic/snomagic commands
vim.o.inccommand = "split"

-- always display signcolumn
vim.o.signcolumn = "yes"

-- rounded borders for all floating windows and the completion menu
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"

-- use ripgrep instead of grep
vim.o.grepprg = "rg --vimgrep --smart-case --follow"

-- use treesitter as default fold method, start with everything unfolded
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99
