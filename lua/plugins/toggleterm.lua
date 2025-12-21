return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shading_factor = 0,
        shading_ratio = 0,
        direction = "float",
        open_mapping = [[<M-t>]],
        shell = "pwsh",
        float_opts = {
            border = "curved",
            width = function()
                return vim.o.columns
            end,
            height = function()
                return vim.o.lines
            end,
        },
    },
}
