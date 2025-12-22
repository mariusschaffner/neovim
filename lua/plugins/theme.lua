return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({})
            vim.cmd("colorscheme onedark_vivid")

            -- highlight cursor line
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4452" })

            -- change diffview colors
            vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "#1e4620" })
            vim.api.nvim_set_hl(0, "DiffDelete", { fg = "NONE", bg = "#462020" })
            vim.api.nvim_set_hl(0, "DiffChange", { fg = "NONE", bg = "#1e3a5f" })
            vim.api.nvim_set_hl(0, "DiffText", { fg = "NONE", bg = "#265478" })

            -- change float window colors
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "ToggleTerm1FloatBorder", { fg = "#00f2ff", bg = "NONE" })


            -- change floating window appereance
            vim.api.nvim_set_hl(0, "PMenu", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#00f2ff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#820857", bg = "NONE" })
            vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE" })

            -- change global win seperator
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#00f2ff" })
        end,
    },
}
