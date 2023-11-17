return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")

    -- colorscheme
    use("EdenEast/nightfox.nvim")

    -- save as root
    use("lambdalisue/suda.vim")

    -- icons
    use("nvim-tree/nvim-web-devicons")

    -- better diff mode
    use({
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({
                merge_tool = {
                    layout = "diff3_mixed",
                },
            })
        end,
    })

    -- LaTex syntax and preview
    use("lervag/vimtex")

    -- jinja2 syntax
    use("Glench/Vim-Jinja2-Syntax")

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- neorg {{{
    use({
        "nvim-neorg/neorg",
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            })
        end,
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    })
    -- }}}

    -- Markdown preview {{{
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    -- }}}

    -- Plant UML syntax and preview {{{
    use("aklt/plantuml-syntax")
    use({
        "https://gitlab.com/itaranto/plantuml.nvim",
        tag = "*",
        config = function()
            require("plantuml").setup({
                renderer = {
                    type = "imv",
                    options = {
                        dark_mode = true,
                    },
                },
                render_on_write = true,
            })
        end,
    })
    -- }}}

    -- treesitter - syntax hl, ast manipulation {{{
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.treesitter").setup()
        end,
        run = ":TSUpdate",
    })
    -- }}}

    -- statusline {{{
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config.lualine").setup()
        end,
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    -- }}}

    -- better movements {{{
    use({
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end,
        branch = "v2",
        as = "hop",
    })
    -- }}}

    -- mini.nvim -- multiple text manipulation plugins {{{
    use({
        "echasnovski/mini.nvim",
        branch = "stable",
        config = function()
            require("config.mini.pairs").setup()
        end,
    })
    -- }}}

    -- surround operator {{{
    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    })
    -- }}}

    -- tpope git, better netrw, better substitution {{{
    use("tpope/vim-fugitive")
    -- use("tpope/vim-vinegar")
    use("tpope/vim-abolish")
    -- }}}

    -- netrw replacement {{{
    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
        end,
    })
    -- }}}

    -- git info {{{
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsigns").setup()
        end,
        requires = "nvim-lua/plenary.nvim",
    })
    -- }}}

    -- keybinds with explanation {{{
    use({
        "folke/which-key.nvim",
        config = function()
            require("config.which-key").setup()
        end,
    })
    -- }}}

    -- LSP & completion & snippets {{{
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            { "neovim/nvim-lspconfig" },
            { "onsails/lspkind-nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "saadparwaiz1/cmp_luasnip" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            require("config.lsp").setup()
        end,
    })

    -- nicer lsp ui
    use({
        "nvimdev/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lspsaga").setup({})
        end,
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
    })

    -- nicer diagnostics
    use({
        "folke/lsp-trouble.nvim",
        config = function()
            require("trouble").setup({
                auto_preview = false,
                auto_fold = true,
                auto_close = true,
            })
        end,
    })
    -- }}}

    -- Fuzzy filtering {{{
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({ "nvim-telescope/telescope-live-grep-args.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope").setup()
        end,
        requires = "nvim-lua/plenary.nvim",
    })
    -- }}}

    -- Rust development {{{
    use("pest-parser/pest.vim")
    -- }}}

    -- Go development {{{
    use({ "ray-x/guihua.lua", run = "cd lua/fzy && make" })
    use({
        "ray-x/go.nvim",
        config = function()
            require("config.go").setup()
        end,
        ft = { "go", "gomod" },
    })
    -- }}}

    -- cue lang {{{
    use("jjo/vim-cue")
    -- }}}

    -- terraform {{{
    use("hashivim/vim-terraform")
    -- }}}

    -- DAP {{{
    use({
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.lldb = {
                type = "executable",
                command = "rustup run stable lldb-vscode",
                name = "lldb",
            }
            dap.configurations.rust = {
                {
                    type = "lldb",
                    request = "launch",
                    program = function()
                        vim.fn.jobstart("cargo build")
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/target/debug/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = function()
                        local args = vim.fn.input("Program arguments: ")
                        return vim.split(args, " ", { trimempty = true, plain = true })
                    end,
                },
            }
        end,
    })
    use({
        "leoluz/nvim-dap-go",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dap-go").setup()
        end,
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup({})
        end,
    })
    -- }}}
end)
