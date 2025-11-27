local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- set space as leader key
vim.g.mapleader = " "

---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

require("lazy").setup({ import = "plugins" }, {
    change_detection = {
        notify = false,
    },
})

vim.cmd [[ colorscheme nordfox ]]
vim.cmd [[ command! Pol execute ":set spelllang=pl spell" ]]
vim.cmd [[ command! Eng execute ":set spelllang=en spell" ]]
