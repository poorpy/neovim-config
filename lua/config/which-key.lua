local M = {
    config = {
        setup = {
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                presets = {
                    -- operators = true, -- adds help for operators like d, y, ...
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                },
                spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
            },
            -- operators = { gc = "Comments" },
            popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            window = {
                border = "none", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                -- align = "center",
            },
            ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
            hidden = {
                "<silent>",
                "<cmd>",
                "<Cmd>",
                "<cr>",
                "call",
                "lua",
                "^:",
                "^ ",
            }, -- hide mapping boilerplate
            show_help = true, -- show help message on the command line when the popup is visible
        },

        opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        },
        vopts = {
            mode = "v", -- VISUAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        },
        secopts = {
            mode = "n", -- NORMAL mode
            prefix = "\\",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        },
        secvopts = {
            mode = "v", -- VISUAL mode
            prefix = "\\",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        },
        -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
        -- see https://neovim.io/doc/user/map.html#:map-cmd
        secmappings = {
            ["q"] = {
                name = "Quickfix list",
                ["o"] = { "<cmd>copen<cr>", "Open quickfix list window" },
                ["c"] = { "<cmd>cclose<cr>", "Close quickfix list window" },
                ["C"] = { "<cmd>call setqflist([])<cr>", "Clear quickfix list" },
                ["n"] = { "<cmd>cnext<cr>", "Select next item in quickfix list" },
                ["p"] = { "<cmd>cprev<cr>", "Select previous item in quickfix list" },
            },
        },
        secvmappings = {},
        vmappings = {
            ["g"] = {
                name = "Git",
                ["s"] = {
                    '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
                    "Stage Hunk",
                },
                ["r"] = {
                    '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
                    "Undo Stage Hunk",
                },
            },
            ["l"] = {
                name = "LSP",
                ["a"] = {
                    "<cmd>Lspsaga code_action<cr>",
                    "Code Action Range",
                },
            },
            ["s"] = {
                name = "Search",
                ["v"] = {
                    '<cmd>lua require"config.telescope".grep_string_visual()<CR>',
                    "Visual selection",
                },
            },
        },
        mappings = {
            ["<leader>"] = {
                "<cmd>lua vim.lsp.buf.format()<cr>",
                "Format file using lsp",
            },
            ["'"] = {
                "<cmd>1ToggleTerm size=15 direction=horizontal<cr>",
                "Open toggle terminal",
            },
            ['"'] = {
                "<cmd>tabnew | term <CR>",
                "Open terminal",
            },
            ["w"] = { "<cmd>w!<cr>", "Save" },
            ["W"] = { "<cmd>SudaWrite<cr>", "Sudo Save" },
            ["q"] = { "<cmd>q!<cr>", "Quit" },
            ["n"] = { "<cmd>Oil<cr>", "File explorer" },
            ["f"] = { "<cmd>Telescope live_grep_args<cr>", "Grep" },
            ["F"] = { "<cmd>Telescope file_browser<cr>", "File browser" },
            ["p"] = {
                name = "Packer",
                ["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
                ["i"] = { "<cmd>PackerInstall<cr>", "Install" },
                ["s"] = { "<cmd>PackerSync<cr>", "Sync" },
                ["u"] = { "<cmd>PackerUpdate<cr>", "Update" },
            },
            ["d"] = {
                name = "Debug",
                ["R"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
                ["E"] = {
                    "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
                    "Evaluate Input",
                },
                ["C"] = {
                    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
                    "Conditional Breakpoint",
                },
                ["U"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
                ["b"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
                ["c"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
                ["d"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
                ["e"] = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
                ["g"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
                ["h"] = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
                ["S"] = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
                ["i"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
                ["o"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
                ["p"] = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
                ["q"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
                ["r"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
                ["s"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
                ["t"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
                ["x"] = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
                ["u"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
            },
            ["g"] = {
                name = "Git",
                ["g"] = {
                    "<cmd>Git<cr>",
                    "Fugitive",
                },
                ["j"] = {
                    '<cmd>lua require"gitsigns".next_hunk()<cr>',
                    "Next Hunk",
                },
                ["k"] = {
                    '<cmd>lua require"gitsigns".prev_hunk()<cr>',
                    "Prev Hunk",
                },
                ["l"] = {
                    '<cmd>lua require"gitsigns".blame_line{full=true}<cr>',
                    "Blame Line",
                },
                ["P"] = {
                    '<cmd>lua require"gitsigns".preview_hunk()<cr>',
                    "Preview Hunk",
                },
                ["r"] = {
                    '<cmd>lua require"gitsigns".reset_hunk()<cr>',
                    "Reset Hunk",
                },
                ["R"] = {
                    '<cmd>lua require"gitsigns".reset_buffer()<cr>',
                    "Reset Buffer",
                },
                ["s"] = {
                    '<cmd>lua require"gitsigns".stage_hunk()<cr>',
                    "Stage Hunk",
                },
                ["S"] = {
                    '<cmd>lua require"gitsigns".stage_buffer()<cr>',
                    "Stage Buffer",
                },
                ["u"] = {
                    '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
                    "Undo Stage Hunk",
                },
                ["D"] = {
                    '<cmd>lua require"gitsigns".diffthis()<cr>',
                    "Diff this file",
                },
                ["o"] = { "<cmd>Telescope git_status<cr>", "Open changed files" },
                ["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                ["c"] = {
                    "<cmd>Git commit<cr>",
                    "Fugitive",
                },
                ["C"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                ["d"] = {
                    name = "Diffview",
                    ["o"] = { "<cmd>DiffviewOpen<cr>", "Open" },
                    ["c"] = { "<cmd>DiffviewClose<cr>", "Close" },
                    ["h"] = { "<cmd>DiffviewFileHistory<cr>", "History" },
                    ["H"] = { "<cmd>DiffviewFileHistory %<cr>", "History for current file only" },
                    ["r"] = { "<cmd>DiffviewRefresh<cr>", "Refresh stats and entries" },
                    ["f"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle files panel" },
                },
                ["t"] = {
                    name = "Toggle",
                    ["b"] = {
                        '<cmd>lua require"gitsigns".toggle_current_line_blame()<cr>',
                        "Blame line",
                    },
                    ["d"] = { '<cmd>lua require"gitsigns".toggle_deleted()<cr>', "Deleted" },
                    ["h"] = { '<cmd>lua require"gitsigns".toggle_linehl()<cr>', "Line highlight" },
                },
                ["y"] = {
                    '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
                    "Copy link to clipboard",
                },
                ["p"] = {
                    "<cmd>Git push<cr>",
                    "Git push",
                },
            },
            ["h"] = {
                name = "Hop",
                ["c"] = { "<cmd>HopChar1<cr>", "Hop to single char" },
                ["C"] = { "<cmd>HopChar2<cr>", "Hop to bigram" },
                ["l"] = { "<cmd>HopLine<cr>", "Hop to line" },
                ["L"] = { "<cmd>HopLineStart<cr>", "Hop to line start" },
                ["p"] = { "<cmd>HopPattern<cr>", "Hop to pattern" },
                ["w"] = { "<cmd>HopWord<cr>", "Hop to word" },
            },
            ["l"] = {
                name = "LSP",
                ["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
                ["c"] = {
                    name = "Codelens",
                    ["r"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run" },
                    ["d"] = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display" },
                    ["u"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Update" },
                },
                ["d"] = { "<cmd>Trouble<cr>", "Workspace Diagnostics (Trouble)" },
                ["D"] = {
                    "<cmd>Telescope diagnostics<cr>",
                    "Workspace Diagnostics (Telescope)",
                },
                ["k"] = {
                    "<cmd>Lspsaga hover_doc<cr>",
                    "Show hover doc",
                },
                ["i"] = { "<cmd>LspInfo<cr>", "Info" },
                ["q"] = {
                    "<cmd>lua vim.diagnostic.setqflist()<cr>",
                    "Set quickfix list",
                },
                ["n"] = {
                    "<cmd>lua vim.diagnostic.goto_next()<cr>",
                    "Next Diagnostic",
                },
                ["p"] = {
                    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                    "Prev Diagnostic",
                },
                ["r"] = { "<cmd>Lspsaga rename<cr>", "Rename" },
                ["o"] = {
                    "<cmd>LSoutlineToggle<cr>",
                    "Outline toggle",
                },
                ["s"] = {
                    "<cmd>Telescope lsp_document_symbols<cr>",
                    "Document Symbols",
                },
                ["S"] = {
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    "Workspace Symbols",
                },
                ["t"] = {
                    name = "Toggle diagnostic",
                    ["s"] = {
                        "<cmd>vim.diagnostic.show(nil, 0)<cr>",
                        "Show diagnostic for buffer",
                    },
                    ["h"] = {
                        "<cmd>vim.diagnostic.show(nil, 0)<cr>",
                        "Hide diagnostic for buffer",
                    },
                    ["S"] = {
                        "<cmd>vim.diagnostic.show()<cr>",
                        "Show diagnostic for all buffers",
                    },
                    ["H"] = {
                        "<cmd>vim.diagnostic.hide()<cr>",
                        "Hide diagnostic for all buffers",
                    },
                },
            },
            ["m"] = {
                name = "Tasks",
                ["g"] = { "<cmd>GoTestFunc<cr>", "Run go test function" },
            },
            ["s"] = {
                name = "Search",
                ["b"] = { "<cmd>Telescope buffers<cr>", "Find buffer" },
                ["c"] = { "<cmd>Telescope commands<cr>", "Commands" },
                ["f"] = { "<cmd>Telescope find_files<cr>", "Find file" },
                ["g"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                ["h"] = { "<cmd>Telescope command_history<cr>", "Find command history" },
                ["H"] = { "<cmd>Telescope help_tags<cr>", "Find help" },
                ["L"] = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
                ["k"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                ["m"] = { "<cmd>Telescope marks<cr>", "Marks" },
                ["M"] = { "<cmd>Telescope man_pages<cr>", "Man pages" },
                ["o"] = { "<cmd>Telescope oldfiles<cr>", "Open old files" },
                ["r"] = { "<cmd>Telescope resume<cr>", "Open previous search" },
                ["t"] = { "<cmd>Telescope live_grep_args<cr>", "Text" },
                ["T"] = { "<cmd>Telescope live_grep<cr>", "Text without args" },
                ["Q"] = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
                ["w"] = { "<cmd>Telescope grep_string<cr>", "Word under cursor" },
            },
            ["r"] = {
                name = "Replace",
                ["n"] = { "<cmd>Lspsaga rename<CR>", "Rename symbol under cursor" },
            },
        },
    },
}

M.setup = function()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
        return
    end

    which_key.setup(M.config.setup)
    which_key.register(M.config.mappings, M.config.opts)
    which_key.register(M.config.vmappings, M.config.vopts)
    which_key.register(M.config.secmappings, M.config.secopts)
    which_key.register(M.config.secvmappings, M.config.secvopts)
end

return M
