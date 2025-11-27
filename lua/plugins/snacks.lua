return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true },
        toggle = { enabled = true },
        styles = {
            zen = {
                enter = true,
                fixbuf = false,
                minimal = false,
                width = 240,
                height = 0,
                backdrop = { transparent = false, blend = 40 },
                keys = { q = false },
                zindex = 40,
                wo = {
                    winhighlight = "NormalFloat:Normal",
                },
                w = {
                    snacks_main = true,
                },
            },
        },
    },
    keys = {
        -- Snacks.picker {{{
        {
            "<leader>sf",
            function()
                Snacks.picker.smart()
            end,
            desc = "Files",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help pages",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>sG",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep open buffers",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>sD",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Buffer Diagnostics",
        },
        {
            "<leader>sc",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>sC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>sl",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "gai",
            function()
                Snacks.picker.lsp_incoming_calls()
            end,
            desc = "C[a]lls Incoming",
        },
        {
            "gao",
            function()
                Snacks.picker.lsp_outgoing_calls()
            end,
            desc = "C[a]lls Outgoing",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
        {
            "<leader>su",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo History",
        },
        -- }}}
        -- Snacks.toggle {{{
        {
            "<leader>ti",
            function()
                Snacks.toggle.inlay_hints()
            end,
            desc = "Toggle inlay hints",
        },
        {
            "<leader>tz",
            function()
                Snacks.zen()
            end,
            desc = "Toggle zen mode",
        },
        -- }}}
        -- Snacks.terminal {{{
        {
            "<leader>tj",
            function()
                Snacks.terminal.toggle "jjui"
            end,
            desc = "Toggle jjui",
        },

        -- }}}
    },
}
