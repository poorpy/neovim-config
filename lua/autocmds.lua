local vimrc_group = vim.api.nvim_create_augroup("vimrc", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Autoformat before save",
    pattern = { "*.go", "*.lua", "*.yml", "*.json", "*.py", "*.rs" },
    callback = function()
        vim.lsp.buf.format()
    end,
    group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Fix imports before save",
    pattern = { "*.go", "*.rs" },
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end,
    group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Source new nvim config file",
    pattern = { vim.fn.stdpath("config") .. "/**/*.lua" },
    command = "source <afile>",
    group = vimrc_group,
})

local highlight_group = vim.api.nvim_create_augroup("Highlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
    end,
    group = highlight_group,
})
