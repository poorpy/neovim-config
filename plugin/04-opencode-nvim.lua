vim.pack.add {
    {
        src = "https://github.com/nickjvandyke/opencode.nvim",
        version = vim.version.range "*",
    },
    "https://github.com/folke/snacks.nvim",
}

local opencode = require "opencode"
vim.g.opencode_opts = {}
vim.o.autoread = true -- Required for `opts.events.reload`

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<C-a>", function()
    opencode.ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })

vim.keymap.set({ "n", "x" }, "<C-x>", function()
    opencode.select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "t" }, "<C-.>", function()
    opencode.toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
    return opencode.operator "@this "
end, { desc = "Add range to opencode", expr = true })

vim.keymap.set("n", "goo", function()
    return opencode.operator "@this " .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
    opencode.command "session.half.page.up"
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
    opencode.command "session.half.page.down"
end, { desc = "Scroll opencode down" })

-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
