local is_java_user = os.getenv "USER" == "bmarczyn"

vim.pack.add {
    "https://github.com/neovim/nvim-lspconfig",
}

if is_java_user then
    vim.pack.add {
        {
            src = "https://github.com/JavaHello/spring-boot.nvim",
            version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
        },
        "https://github.com/MunifTanjim/nui.nvim",
        "https://github.com/mfussenegger/nvim-dap",
        "https://github.com/nvim-java/nvim-java",
    }
end

--- ccls {{{
vim.lsp.config("ccls", {
    init_options = {
        cache = {
            hierarchicalPath = true,
        },
        index = {
            initialBlacklist = { ".*/boost/.*" },
        },
    },
})
--- }}}

-- rust_analyzer {{{
vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    },
})
-- }}}

-- gopls {{{
vim.lsp.config("gopls", {
    flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 500,
    },
    settings = {
        gopls = {
            analyses = {
                nilness = true,
                unusedwrite = true,
                unusedparams = true,
                unreachable = true,
                ST1000 = false,
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
    },
})
-- }}}

vim.lsp.enable {
    "ty",
    "ccls",
    "ruff",
    "gopls",
    "templ",
    "buf_ls",
    "lua_ls",
    "rust_analyzer",
    "golangci_lint_ls",
}

-- java {{{
if is_java_user then
    require("java").setup()
    vim.lsp.enable "jdtls"
end
-- }}}

vim.lsp.codelens.enable(true)
vim.lsp.log.set_level(vim.log.levels.ERROR)

-- lsp attach {{{
-- built-in defaults cover: K (hover), grn (rename), gra (code action), grr (references),
-- gri (implementation), grt (type definition), gO (symbols), <C-w>d (diagnostics), <C-s> (signature)
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set(
                "n",
                keys,
                func,
                { buffer = event.buf, noremap = true, silent = true, desc = "LSP: " .. desc }
            )
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>ce", vim.diagnostic.open_float, "[C]ode [E]rror")
        map("<leader>cf", function()
            require("conform").format { lsp_format = "fallback" }
        end, "[C]ode [F]ormat")
    end,
})
-- }}}
