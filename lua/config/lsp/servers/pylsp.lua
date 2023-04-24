local M = {}

M.settings = {
    pylsp = {
        plugins = {
            pycodestyle = {
                ignore = { "E501", "W503" },
            },
        },
    },
}

return M
