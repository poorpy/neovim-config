return {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
        require("config.mini.pairs").setup()
        require("mini.surround").setup()
        require("mini.ai").setup()
    end,
}
