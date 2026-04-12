vim.pack.add {
    "https://github.com/selimacerbas/live-server.nvim",
    {
        src = "https://github.com/selimacerbas/markdown-preview.nvim",
        version = vim.version.range "1.*",
    },
}

require("markdown_preview").setup {
    port = 8421,
    open_browser = true,
    debounce_ms = 300,
}

local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

nmap("<leader>mps", "<cmd>MarkdownPreview<cr>", "Markdown: Start preview")
nmap("<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", "Markdown: Stop preview")
nmap("<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", "Markdown: Refresh preview")
