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

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    desc = "Recognize .h files as C headers",
    pattern = { "*.h" },
    command = "setlocal filetype=c",
    group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    desc = "Recognize .yml files as ansible config",
    pattern = { "*/ansible/*.yml" },
    command = "setlocal filetype=yaml.ansible",
    group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    desc = "Recognize yaml jinja2 templates",
    pattern = { "*.(yaml|yml).(j2|jinja2)" },
    command = "setlocal filetype=jinja.yaml",
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
