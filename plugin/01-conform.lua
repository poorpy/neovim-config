vim.pack.add {
    "https://github.com/stevearc/conform.nvim",
}

local conform = require "conform"
conform.formatters.terraform_fmt = {
    command = "tofu",
}

conform.formatters.clippy = {
    method = "cli",
    command = "cargo",
    args = {
        "clippy",
        "--fix",
        "--allow-dirty",
        "--allow-staged",
        "--message-format=json",
    },
    stdin = false,
}

conform.setup {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "css_beautify" },
        python = { "ruff" },
        go = { "golangci-lint" },
        zig = { "zigfmt" },
        nix = { "alejandra" },
        rust = { "rustfmt", "clippy" },
    },
}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local disabled = { c = true, cpp = true, h = true }
        if disabled[ft] ~= nil then
            return
        end

        conform.format {
            bufnr = args.buf,
            lsp_fallback = true,
            -- async = true,
            force = true,
            quiet = true,
        }
    end,
})
