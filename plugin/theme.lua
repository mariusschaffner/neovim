vim.pack.add({
  { src = "https://github.com/olimorris/onedarkpro.nvim" },
})

require("onedarkpro").setup({})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "onedark_vivid",
  callback = function()
    -- highlight cursor line
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3e4452" })
    -- change base white
    vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFEFE" })
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
    -- change floating window appearance
    vim.api.nvim_set_hl(0, "PMenu", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#00f2ff", bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#820857", bg = "NONE" })
    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE" })
    -- change global win separator
    vim.api.nvim_set_hl(0, "ColorfulWinSep", { fg = "#ffa502" })
  end,
})

vim.cmd("colorscheme onedark_vivid")
