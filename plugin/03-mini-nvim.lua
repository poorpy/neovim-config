vim.pack.add {
    { src = "https://github.com/nvim-mini/mini.nvim", version = vim.version.range "*" },
}

require("mini.ai").setup { n_lines = 1000 }
require("mini.surround").setup { n_lines = 1000, search_method = "cover_or_prev" }
require("mini.pairs").setup()

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

require("mini.pick").setup()
require("mini.extra").setup()

-- replaces flash.nvim; default mapping: <CR> starts jumping
require("mini.jump2d").setup()
vim.api.nvim_create_autocmd("FileType", {
    desc = "Keep <CR> for jumping to entries in quickfix/location list",
    group = vim.api.nvim_create_augroup("MiniJump2dDisable", { clear = true }),
    pattern = "qf",
    callback = function(ev)
        vim.b[ev.buf].minijump2d_disable = true
    end,
})

-- replaces nvim-web-devicons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- git branch and diff summary for the statusline, blame
require("mini.git").setup()
nmap("<leader>gb", "<cmd>Git blame -- %<cr>", "[G]it [B]lame")
nmap("<leader>gs", MiniGit.show_at_cursor, "[G]it [S]how at cursor")
require("mini.diff").setup()

-- replaces lualine (same layout: mode | branch diff diagnostics | filename ... encoding filetype | progress | location)
require("mini.statusline").setup {
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }

            return MiniStatusline.combine_groups {
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
                "%<",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=",
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = "MiniStatuslineDevinfo", strings = { "%p%%" } },
                { hl = mode_hl, strings = { "%l:%c" } },
            }
        end,
    },
}

-- replaces which-key.nvim
local miniclue = require "mini.clue"
miniclue.setup {
    triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "<LocalLeader>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },
    clues = {
        { mode = "n", keys = "<Leader>a", desc = "+[A]I" },
        { mode = "n", keys = "<Leader>c", desc = "+[C]ode" },
        { mode = "n", keys = "<Leader>g", desc = "+[G]it" },
        { mode = "n", keys = "<Leader>m", desc = "+[M]arkdown" },
        { mode = "n", keys = "<Leader>mp", desc = "+[P]review" },
        { mode = "n", keys = "<Leader>r", desc = "+[R]ename" },
        { mode = "n", keys = "<Leader>s", desc = "+[S]earch" },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
    window = { delay = 300 },
}

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
    MiniPick.builtin.grep_live(
        { globs = { "!vendor/**", "!.venv/**", "!.git/**", "!.jj/**" } },
        { source = { show = show_with_icons } }
    )
end, "Grep")
nmap("<leader>sG", function()
    MiniPick.builtin.grep_live(nil, { source = { show = show_with_icons } })
end, "Grep (default)")
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
nmap("<leader>ss", function()
    MiniExtra.pickers.lsp { scope = "document_symbol" }
end, "LSP Symbols")
nmap("<leader>sS", function()
    MiniExtra.pickers.lsp { scope = "workspace_symbol" }
end, "LSP Workspace Symbols")
