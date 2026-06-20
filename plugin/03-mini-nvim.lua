vim.pack.add {
    { src = "https://github.com/nvim-mini/mini.nvim", version = vim.version.range "*" },
}

require("mini.ai").setup { n_lines = 1000 }
require("mini.surround").setup { n_lines = 1000, search_method = "cover_or_prev" }
require("mini.pairs").setup {
    n_lines = 1000,
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = false, terminal = false },

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- `<CR>`, `'` does not insert pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

        ['"'] = {
            action = "closeopen",
            pair = '""',
            neigh_pattern = "[^\\].",
            register = { cr = false },
        },
        ["'"] = {
            action = "closeopen",
            pair = "''",
            neigh_pattern = "[^%a\\].",
            register = { cr = false },
        },
        ["`"] = {
            action = "closeopen",
            pair = "``",
            neigh_pattern = "[^\\].",
            register = { cr = false },
        },
    },
}

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

require("mini.pick").setup()
require("mini.extra").setup()

local show_with_icons = function(buf_id, items, query)
    MiniPick.default_show(buf_id, items, query, { show_icons = true })
end
nmap("<leader>sf", function()
    local command = {
        "fd",
        "--type=file",
        "--color=never",
        "--exclude=vendor",
    }
    MiniPick.builtin.cli(
        { command = command },
        { source = { name = "Files", show = show_with_icons } }
    )
end, "Files")
nmap("<leader>sF", function()
    local command = {
        "fd",
        "--type=file",
        "--color=never",
        "--hidden",
        "--exclude=.git",
        "--exclude=.jj",
        "--exclude=.venv",
        "--exclude=vendor",
    }
    MiniPick.builtin.cli(
        { command = command },
        { source = { name = "Files (hidden)", show = show_with_icons } }
    )
end, "Files (hidden)")
nmap("<leader>sh", function()
    MiniPick.builtin.help()
end, "Help pages")
nmap("<leader>sg", function()
    MiniPick.builtin.grep_live()
end, "Grep")
nmap("<leader>sd", function()
    MiniExtra.pickers.diagnostic { scope = "all" }
end, "Diagnostics")
nmap("<leader>sD", function()
    MiniExtra.pickers.diagnostic { scope = "current" }
end, "Buffer Diagnostics")
nmap("<leader>sc", function()
    MiniExtra.pickers.history { scope = ":" }
end, "Command History")
nmap("<leader>sC", function()
    MiniExtra.pickers.commands()
end, "Commands")
nmap("<leader>sb", function()
    MiniPick.builtin.buffers()
end, "Buffers")
nmap("<leader>sl", function()
    MiniExtra.pickers.buf_lines { scope = "current" }
end, "Buffer Lines")
nmap("gd", function()
    MiniExtra.pickers.lsp { scope = "definition" }
end, "Goto Definition")
nmap("gD", function()
    MiniExtra.pickers.lsp { scope = "declaration" }
end, "Goto Declaration")
nmap("gr", function()
    MiniExtra.pickers.lsp { scope = "references" }
end, "References")
nmap("gI", function()
    MiniExtra.pickers.lsp { scope = "implementation" }
end, "Goto Implementation")
nmap("gy", function()
    MiniExtra.pickers.lsp { scope = "type_definition" }
end, "Goto T[y]pe Definition")
nmap("<leader>ss", function()
    MiniExtra.pickers.lsp { scope = "document_symbol" }
end, "LSP Symbols")
nmap("<leader>sS", function()
    MiniExtra.pickers.lsp { scope = "workspace_symbol" }
end, "LSP Workspace Symbols")
