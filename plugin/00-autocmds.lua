local highlight_group = vim.api.nvim_create_augroup("Highlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.hl.on_yank { higroup = "IncSearch", timeout = 400 }
    end,
    group = highlight_group,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Start treesitter highlighting when a parser is available",
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
    group = highlight_group,
})
