return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")

    -- colorscheme
    use("tyrannicaltoucan/vim-deep-space")

    -- save as root
    use("lambdalisue/suda.vim")

    -- icons
    use("kyazdani42/nvim-web-devicons")

    -- better diff mode
    use("sindrets/diffview.nvim")

    -- LaTex syntax and preview
    use("lervag/vimtex")

    -- jinja2 syntax
    use("Glench/Vim-Jinja2-Syntax")

    -- Platform independent LSP and debugger install {{{
    use({
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    })

    use({
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {},
            })
        end,
    })
    -- }}}

    -- Markdown preview {{{
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
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
            require("config.mini.comment").setup()
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

    -- better built-in terminal {{{
    use({
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require("config.terminal").setup()
        end,
    })
    use({
        "willothy/flatten.nvim",
        config = function()
            require("flatten").setup({
                window = {
                    open = "tab",
                    focus = "first",
                },
            })
        end,
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

    -- LSP {{{
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("config.lsp.init")
        end,
        after = { "nvim-cmp" },
    })

    -- nicer diagnostics
    use({
        "folke/lsp-trouble.nvim",
        config = function()
            require("trouble").setup({ auto_preview = false, auto_fold = true, auto_close = true })
        end,
    })

    -- better lsp UI
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({})
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

    -- completion & snippets {{{
    use("onsails/lspkind-nvim")
    use({
        "L3MON4D3/LuaSnip",
        requires = "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").filetype_extend("handlebars", { "html" })
        end,
    })
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-emoji")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use({
        "hrsh7th/nvim-cmp",
        after = {
            "lspkind-nvim",
            "LuaSnip",
            "cmp_luasnip",
            "cmp-nvim-lua",
            "cmp-nvim-lsp",
            "cmp-buffer",
            "cmp-path",
            "cmp-calc",
            "cmp-emoji",
        },
        config = function()
            require("config.cmp").setup()
        end,
    })
    use({
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    })
    use({
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
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
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup({})
        end,
    })
    -- }}}
end)
