return {
    {
        "selimacerbas/markdown-preview.nvim",
        dependencies = { "selimacerbas/live-server.nvim" },
        version = "1.4.0",
        keys = {
            { "<leader>mps", "<cmd>MarkdownPreview<cr>", desc = "Markdown: Start preview" },
            { "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown: Stop preview" },
            {
                "<leader>mpr",
                "<cmd>MarkdownPreviewRefresh<cr>",
                desc = "Markdown: Refresh preview",
            },
        },
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewRefresh",
        },
        config = function()
            require("markdown_preview").setup {
                port = 8421,
                open_browser = true,
                debounce_ms = 300,
            }
        end,
    },
}
