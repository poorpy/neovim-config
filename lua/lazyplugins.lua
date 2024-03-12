return require("lazy").setup({
    -- colorscheme
    "EdenEast/nightfox.nvim",

    -- util lib for plugins
    "nvim-lua/plenary.nvim",

    -- save as root
    "lambdalisue/suda.vim",

    -- icons
    "nvim-tree/nvim-web-devicons",

    -- notifications UI {{{
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    -- }}}

    -- comment block of text {{{
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    -- }}}

    -- treesitter - syntax hl, ast manipulation {{{
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.treesitter").setup()
        end,
        build = ":TSUpdate",
    },
    -- }}}

    -- statusline {{{
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config.lualine").setup()
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- }}}

    -- mini.nvim -- multiple text manipulation plugins {{{
    {
        "echasnovski/mini.nvim",
        branch = "stable",
        config = function()
            require("config.mini.pairs").setup()
        end,
    },
    -- }}}

    -- surround operator {{{
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- }}}

    -- fuzzy filtering {{{
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("config.telescope").setup()
        end,
    },

    -- }}}

    -- git tui {{{
    {
        "NeogitOrg/neogit",
        dependencies = {
            { "nvim-lua/plenary.nvim" },

            -- diffview {{{
            {
                "sindrets/diffview.nvim",
                config = function()
                    require("diffview").setup({
                        view = {
                            merge_tool = {
                                layout = "diff3_mixed",
                            },
                        },
                    })
                end,
            },
            -- }}}

            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("neogit").setup()
            vim.keymap.set("n", "<leader>gg", function()
                require("neogit").open()
            end, { noremap = true, silent = true, desc = "Open Neogit" })
            vim.keymap.set("n", "<leader>gc", function()
                require("neogit").open({ "commit" })
            end, { noremap = true, silent = true, desc = "Open Neogit Commit" })
            vim.keymap.set("n", "<leader>gp", function()
                require("neogit").open({ "push" })
            end, { noremap = true, silent = true, desc = "Open Neogit Commit" })
        end,
    },
    -- }}}

    -- text case manipulation {{{
    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
    },
    -- }}}

    -- git info {{{
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsigns").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- }}}

    -- LSP & completion & snippets {{{
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "onsails/lspkind-nvim",
            "nvimtools/none-ls.nvim",
            "j-hui/fidget.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("config.lsp").setup()
        end,
    },
    -- }}}

    -- keybinds with explanation {{{
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
            require("which-key").register({
                ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
                ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
                ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
                ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
                ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
                ["<leader>f"] = { name = "[F]lash", _ = "which_key_ignore" },
            })
        end,
    },
    -- }}}

    -- netrw replacement {{{
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
        end,
    },
    -- }}}

    -- additional motions {{{
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            {
                "<leader>fj",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "[F]lash [J]ump",
            },
            {
                "<leader>ft",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "[F]lash [T]reesitter",
            },
        },
    },
    -- }}}
})
