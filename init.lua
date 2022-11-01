require("keybinds")
require("settings")
require("plugins")
require("autocmds")

vim.cmd([[ colorscheme deep-space ]])
vim.cmd([[ hi MatchParen guifg=#c47ebd guibg=#51617d ]])
vim.cmd([[ command! Pol execute ":set spelllang=pl spell"]])
vim.cmd([[ command! Eng execute ":set spelllang=en spell"]])
