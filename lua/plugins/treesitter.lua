return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                branch = "master",
                lazy = false,
            },
        },
        config = function()
            require("config.treesitter").setup()
        end,
    },
}
