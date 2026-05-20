vim.pack.add {
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/onsails/lspkind.nvim",
    "https://github.com/folke/lazydev.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
}

local lazydev = require "lazydev"
lazydev.setup {
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
    },
}
require("blink.cmp").setup {
    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
    },
    keymap = {
        preset = "default",
        ["<C-j>"] = { "snippet_forward" },
        ["<C-k>"] = { "snippet_backward" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },

        documentation = {
            auto_show = true,
            treesitter_highlighting = true,
            window = { border = "rounded" },
        },

        list = {
            selection = {
                preselect = true,
                auto_insert = true,
            },
        },
    },

    -- Experimental signature help support
    signature = {
        enabled = true,
        window = { border = "rounded" },
    },

    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
            snippets = {
                opts = {
                    friendly_snippets = true,
                    filter_snippets = function(ft, file)
                        if ft == "go" and string.match(file, "friendly.snippets") then
                            return false
                        end
                        return true
                    end,
                },
            },
        },
    },
}
