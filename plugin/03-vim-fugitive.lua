vim.pack.add {
    "https://github.com/tpope/vim-fugitive",
}

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end
nmap("<leader>gg", "<cmd>Git<cr>", "[G]it")
nmap("<leader>gb", "<cmd>Git blame<cr>", "[G]it [B]lame")
nmap("<leader>gl", "<cmd>Git log<cr>", "[G]it [L]og")
nmap("<leader>gc", "<cmd>Git commit<cr>", "[G]it [C]ommit")
nmap("<leader>gp", "<cmd>Git pull<cr>", "[G]it [P]ull")
nmap("<leader>gP", "<cmd>Git push<cr>", "[G]it [P]ush")
