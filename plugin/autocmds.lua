local highlight_group = vim.api.nvim_create_augroup("Highlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.hl.on_yank { higrou = "IncSearch", timeout = 400 }
    end,
    group = highlight_group,
})

local fold_group = vim.api.nvim_create_augroup("Fold", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    desc = "Unfold folds on enter",
    callback = function(ev)
        if string.match(ev.match, "%.lua$") then
            return
        end

        vim.cmd [[ normal zR ]]
    end,
    group = fold_group,
})
