vim.pack.add {
    "https://github.com/stevearc/quicker.nvim",
}

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

local quicker = require "quicker"

nmap("<leader>q", quicker.toggle, "Toggle quickfix")

quicker.setup {
    keys = {
        {
            ">",
            function()
                require("quicker").expand { before = 2, after = 2, add_to_existing = true }
            end,
            desc = "Expand quickfix context",
        },
        {
            "<",
            function()
                require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
        },
    },
}
