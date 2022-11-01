local M = {}

local black = require("config/efm/black")
local isort = require("config/efm/isort")
local mypy = require("config/efm/mypy")
local prettierd = require("config/efm/prettierd")
local stylua = require("config/efm/stylua")

M.init_options = { documentFormatting = true }
M.root_dir = vim.loop.cwd
M.settings = {
    rootMarkers = { ".git/" },
    languages = {
        lua = { stylua },
        python = { black, isort, mypy },
        typescript = { prettierd },
        javascript = { prettierd },
        yaml = { prettierd },
        json = { prettierd },
        html = { prettierd },
        scss = { prettierd },
        css = { prettierd },
        markdown = { prettierd },
    },
    filetypes = {
        "lua",
        "python",
        "yaml",
        "json",
        "html",
        "scss",
        "css",
        "markdown",
    },
}

return M
