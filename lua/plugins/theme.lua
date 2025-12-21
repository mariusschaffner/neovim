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
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "ToggleTerm1FloatBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#00f2ff" })
            vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "PMenu", { bg = "NONE" })
        end,
    },
}
