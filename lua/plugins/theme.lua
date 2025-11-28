return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({})
            vim.cmd("colorscheme onedark_vivid")
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4452" })
            vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "#1e4620" })
            vim.api.nvim_set_hl(0, "DiffDelete", { fg = "NONE", bg = "#462020" })
            vim.api.nvim_set_hl(0, "DiffChange", { fg = "NONE", bg = "#1e3a5f" })
            vim.api.nvim_set_hl(0, "DiffText", { fg = "NONE", bg = "#265478" })
            vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#00f2ff" })
        end,
    },
}

