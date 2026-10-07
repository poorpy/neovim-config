-- set space as leader key
vim.g.mapleader = " "

local spell = function(lang)
    return function()
        vim.opt_local.spelllang = lang
        vim.opt_local.spell = true
    end
end

vim.api.nvim_create_user_command("Pol", spell "pl", { desc = "Polish spell checking" })
vim.api.nvim_create_user_command("Eng", spell "en", { desc = "English spell checking" })
