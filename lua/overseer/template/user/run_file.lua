return {
    name = "run file",
    builder = function()
        local file = vim.fn.expand "%:p"
        local cmd = { file }
        if vim.bo.filetype == "go" then
            cmd = { "go", "run", file }
        elseif vim.bo.filetype == "zig" then
            cmd = { "zig", "run", file }
        end

        return {
            cmd = cmd,
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = { "sh", "python", "go", "zig" },
    },
}
