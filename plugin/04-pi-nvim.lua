vim.pack.add {
    "https://github.com/pablopunk/pi.nvim",
}

require("pi").setup()

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

local vmap = function(keys, func, desc)
    vim.keymap.set("v", keys, func, { noremap = true, silent = true, desc = desc })
end

-- Ask pi with the current buffer as context
nmap("<leader>ai", ":PiAsk<CR>", "Ask pi")
-- Ask pi with visual selection as context
vmap("<leader>ai", ":PiAskSelection<CR>", "Ask pi (selection)")
