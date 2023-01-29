local M = {}

M.flags = { allow_incremental_sync = true, debounce_text_changes = 500 }
M.settings = {
    gopls = {
        analyses = {
            nilness = true,
            unusewrites = true,
            unusedparams = true,
            unreachable = true,
        },
        codelenses = {
            generate = true,
            gc_details = true,
            test = true,
            tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = "Fuzzy",
        diagnosticsDelay = "500ms",
        symbolMatcher = "fuzzy",
        gofumpt = true,
    },
}
M.filetypes = { "go", "gomod" }

return M
