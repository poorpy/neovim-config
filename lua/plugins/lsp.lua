return {
    --- nvim-lspconfig {{{
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
                    {
                        "mason-org/mason.nvim",
                        opts = {
                            registries = {
                                "github:nvim-java/mason-registry",
                                "github:mason-org/mason-registry",
                            },
                        },
                    },
                },
                enabled = function()
                    return vim.uv.os_get_passwd().username ~= "poorpy"
                end,
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
            vim.g.deprecation_warning = false
            require("config.lsp").setup()
        end,
    },
    --- }}}
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

            require("conform").formatters.clippy = {
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

            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff" },
                    -- go = { "goimports", "golines" },
                    go = { "goimports" },
                    zig = { "zigfmt" },
                    terraform = { "terraform_fmt" },
                    hcl = { "terragrunt_hclfmt" },
                    nix = { "nixpkgs_fmt" },
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

                    require("conform").format {
                        bufnr = args.buf,
                        lsp_fallback = true,
                        -- async = true,
                        force = true,
                        quiet = true,
                    }
                end,
            })
        end,
    },
    -- }}}
    -- go.nvim {{{
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
    -- }}}
}
