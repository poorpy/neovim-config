return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("config.mini.pairs").setup()
        require("mini.surround").setup()
        require("mini.diff").setup()
        require("mini.ai").setup()
    end,
}
