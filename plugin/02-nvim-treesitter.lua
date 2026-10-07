vim.pack.add {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd "nvim-treesitter"
            end
            vim.cmd "TSUpdate"
        end
    end,
})

vim.filetype.add {
    extension = {
        gotmpl = "gotmpl",
        ebnf = "ebnf",
    },
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
    },
}

-- parsers bundled with neovim (c, lua, vim, markdown, markdown_inline, query, vimdoc) are omitted
require("nvim-treesitter").install {
    "bash",
    "cpp",
    "ebnf",
    "fish",
    "go",
    "gotmpl",
    "json",
    "json5",
    "just",
    "html",
    "helm",
    "nix",
    "python",
    "rust",
    "toml",
    "xml",
    "yaml",
}

local nxomap = function(keys, func)
    vim.keymap.set({ "n", "x", "o" }, keys, func, { noremap = true, silent = true })
end

nxomap(
    "]m", -- {{{

    function()
        require("nvim-treesitter-textobjects.move").goto_next_start(
            "@function.outer",
            "textobjects"
        )
    end -- }}}
)
nxomap(
    "]]", -- {{{

    function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end -- }}}
)
nxomap(
    "]o", -- {{{

    function()
        require("nvim-treesitter-textobjects.move").goto_next_start(
            { "@loop.inner", "@loop.outer" },
            "textobjects"
        )
    end -- }}}
)
nxomap(
    "]z", -- {{{

    function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
    end -- }}}
)
nxomap(
    "]M", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end -- }}}
)
nxomap(
    "][", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
    end -- }}}
)
nxomap(
    "[m", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(
            "@function.outer",
            "textobjects"
        )
    end -- }}}
)
nxomap(
    "[[", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(
            "@class.outer",
            "textobjects"
        )
    end -- }}}
)
nxomap(
    "[M", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_previous_end(
            "@function.outer",
            "textobjects"
        )
    end -- }}}
)
nxomap(
    "[]", -- {{{
    function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
    end -- }}}
)
