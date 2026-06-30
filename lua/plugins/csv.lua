return {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
        view = {
            display_mode = "border",
        },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    ft = { "csv" },
    config = function(_, opts)
        require("csvview").setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "csv",
            callback = function()
                vim.cmd("CsvViewEnable")
            end,
        })
    end,
}
