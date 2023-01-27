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
        "lua",
        "make",
        "markdown",
        "python",
        "rust",
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
end

return M
