local highlight_group = vim.api.nvim_create_augroup("Highlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
    end,
    group = highlight_group,
})
