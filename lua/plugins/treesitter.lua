return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").install {
                "bash",
                "c",
                "cpp",
                "fish",
                "json",
                "json5",
                "lua",
                "markdown",
                "markdown_inline",
                "html",
                "nix",
                "python",
                "rust",
                "toml",
                "vim",
                "xml",
                "yaml",
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            {
                "]m", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        "@function.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "]]", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        "@class.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "]o", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        { "@loop.inner", "@loop.outer" },
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "]s", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        "@local.scope",
                        "locals"
                    )
                end, -- }}}
            },
            {
                "]z", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
                end, -- }}}
            },
            {
                "]M", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_end(
                        "@function.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "][", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_end(
                        "@class.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "[m", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start(
                        "@function.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "[[", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start(
                        "@class.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "[M", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end(
                        "@function.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "[]", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end(
                        "@class.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "]d", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_next(
                        "@conditional.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
            {
                "[d", -- {{{
                mode = { "n", "x", "o" },
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous(
                        "@conditional.outer",
                        "textobjects"
                    )
                end, -- }}}
            },
        },
    },
}
