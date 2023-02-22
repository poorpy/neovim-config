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
                ensure_installed = {
                    "lua_ls",
                    "efm",
                    -- "rust_analyzer", -- fails on nixos
                    "gopls",
                    "golangci_lint_ls",
                    "jsonls",
                    "yamlls",
                    -- "texlab", -- fails on nixos
                    -- "marksman", -- markdown, fails on nixos
                    "pyright",
                },
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
            -- I currently decided to use nvim-surround
            -- but maybe I'll switch to this in near future
            -- require("config.mini.surround").setup()
        end,
    })
    -- }}}

    -- surround operator {{{
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    })
    -- }}}

    -- tpope git, better netrw, better substitution {{{
    use("tpope/vim-fugitive")
    use("tpope/vim-vinegar")
    use("tpope/vim-abolish")
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
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope").setup()
        end,
        requires = "nvim-lua/plenary.nvim",
    })

    use({ "nvim-telescope/telescope-file-browser.nvim" })

    use({ "nvim-telescope/telescope-live-grep-args.nvim" })
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
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { "$HOME/.vscode/extensions/amimaro.remix-run-snippets-1.1.0" },
            })
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
    -- }}}
end)
