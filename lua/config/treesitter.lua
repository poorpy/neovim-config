local M = {}

M.config = {
    ensure_installed = {
        "c",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "haskell",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "kdl",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "svelte",
        "nix",
        "toml",
        "typescript",
        "vim",
        "vue",
        "yaml",
    },
    ignore_install = {},
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}

M.setup = function()
    local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
        return
    end
    treesitter_configs.setup(M.config)

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.gotmpl = {
        install_info = {
            url = "https://github.com/ngalaiko/tree-sitter-go-template",
            files = { "src/parser.c" },
        },
        filetype = "gotmpl",
        used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
    }
end

return M
