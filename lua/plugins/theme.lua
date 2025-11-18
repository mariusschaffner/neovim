return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({})
            vim.cmd("colorscheme onedark")
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4452" })
            vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "#1e4620" })    -- green background
            vim.api.nvim_set_hl(0, "DiffDelete", { fg = "NONE", bg = "#462020" }) -- red background
            vim.api.nvim_set_hl(0, "DiffChange", { fg = "NONE", bg = "#1e3a5f" }) -- blue background
            vim.api.nvim_set_hl(0, "DiffText", { fg = "NONE", bg = "#265478" })   -- brighter blue
        end,
    },
}
