vim.pack.add {
    "https://github.com/stevearc/conform.nvim",
}

local conform = require "conform"

conform.setup {
    formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        lua = { "stylua" },
        css = { "css_beautify" },
        python = { "ruff" },
        zig = { "zigfmt" },
        nix = { "alejandra" },
        rust = { "rustfmt" },
        ocaml = { "ocamlformat" },
    },
    -- go: formatting (gofumpt) is handled by gopls through lsp_format = "fallback"
    format_on_save = function(bufnr)
        local disabled = { c = true, cpp = true }
        if disabled[vim.bo[bufnr].filetype] then
            return nil
        end
        return { lsp_format = "fallback", quiet = true }
    end,
}
