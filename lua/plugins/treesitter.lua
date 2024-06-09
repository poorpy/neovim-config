return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        lazy = false,
        config = function()
            require("nvim-treesitter").setup {
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

                ensure_installed = {
                    "lua",
                    "nix",
                    "python",
                    "make",
                    "vim",
                    "json",
                    "json5",
                    "yaml",
                    "toml",
                    "markdown",
                    "markdown_inline",
                },
            }
        end,
    },
}
