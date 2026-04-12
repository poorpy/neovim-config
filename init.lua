-- set space as leader key
vim.g.mapleader = " "

---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

vim.cmd [[ command! Pol execute ":set spelllang=pl spell" ]]
vim.cmd [[ command! Eng execute ":set spelllang=en spell" ]]
