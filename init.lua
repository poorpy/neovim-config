require("keybinds")
require("settings")
require("lazypath")
require("lazyplugins")
require("autocmds")

vim.cmd([[ colorscheme nordfox ]])
vim.cmd([[ command! Pol execute ":set spelllang=pl spell" ]])
vim.cmd([[ command! Eng execute ":set spelllang=en spell" ]])
