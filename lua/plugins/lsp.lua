return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = { library = { "luvit-meta/library" } },
            },

            {
                "nvim-java/nvim-java",
                dependencies = {
                    "mason-org/mason.nvim",
                    version = "1.11.0",
                },
                config = function()
                    require("java").setup()
                end,
            },

            { "j-hui/fidget.nvim", opts = {} },

            "saghen/blink.cmp",

            -- Schema information
            "b0o/SchemaStore.nvim",
        },
        config = function()
            require("config.lsp").setup()
        end,
    },
    -- nvim-lint {{{
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require "lint"

            lint.linters_by_ft = {
                terraform = { "tflint" },
                python = { "mypy" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>L", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
    -- }}}
    -- conform.nvim {{{
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").formatters.terraform_fmt = {
                command = "tofu",
            }

            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    go = { "goimports", "golines" },
                    zig = { "zigfmt" },
                    terraform = { "terraform_fmt" },
                    hcl = { "terragrunt_hclfmt" },
                    nix = { "nixpkgs_fmt" },
                },
            }

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format {
                        bufnr = args.buf,
                        lsp_fallback = true,
                        quiet = true,
                    }
                end,
            })
        end,
    },
    -- }}}
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
    },
}
