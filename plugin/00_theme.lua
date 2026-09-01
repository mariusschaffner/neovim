vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
})

require("kanagawa").setup({
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    overrides = function(colors)
        local theme = colors.theme
        return {
            ["@lsp.type.variable.ps1"] = { fg = "#ef596e" },
            CursorLine = { bg = "#3e4452" },
            Normal = { fg = "#FFFEFE" },
            ColorfulWinSep = { fg = "#ffa502" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { fg = "#00f2ff", bg = "NONE" },
            FloatTitle = { bg = "NONE" },
            WhichKeyFloat = { bg = "NONE" },
            PMenu = { bg = "NONE" },
            BlinkCmpMenu = { bg = "NONE" },
            BlinkCmpMenuBorder = { fg = "#00f2ff", bg = "NONE" },
            BlinkCmpDocBorder = { fg = "#820857", bg = "NONE" },
            BlinkCmpLabelMatch = { bg = "None" },
            RenderMarkdownCode = { bg = '#273349' },
            RenderMarkdownCodeInline = { bg = '#273349' },
            RenderMarkdownCodeFallback = { bg = '#273349' },
            RenderMarkdownCodeBorder = { bg = '#2d4261' },
            RenderMarkdownH1Bg = { fg = '#1e232e', bg = '#8acefa' },
            RenderMarkdownH2Bg = { fg = '#1e232e', bg = '#e48c7d' },
            RenderMarkdownH3Bg = { fg = '#1e232e', bg = '#f3b172' },
            RenderMarkdownH4Bg = { fg = '#1e232e', bg = '#f7ce76' },
            RenderMarkdownH5Bg = { fg = '#1e232e', bg = '#5f8ead' },
            RenderMarkdownH6Bg = { fg = '#1e232e', bg = '#42647a' },
            RenderMarkdownH1 = { fg = '#1e232e' },
            RenderMarkdownH2 = { fg = '#1e232e' },
            RenderMarkdownH3 = { fg = '#1e232e' },
            RenderMarkdownH4 = { fg = '#1e232e' },
            RenderMarkdownH5 = { fg = '#1e232e' },
            RenderMarkdownH6 = { fg = '#1e232e' },
            StatusLine = { bg = "None" },
            StBase = { link = "StatusLine" },
            StModeNormal = { fg = theme.ui.bg, bg = theme.syn.fun, bold = true },
            StModeInsert = { fg = theme.ui.bg, bg = theme.diag.ok, bold = true },
            StModeVisual = { fg = theme.ui.bg, bg = theme.syn.keyword, bold = true },
            StModeOther = { fg = theme.ui.bg, bg = theme.vcs.changed, bold = true },
            StGitBranch = { fg = theme.syn.fun, bold = true },
            StGitAdd = { fg = theme.vcs.added },
            StGitChange = { fg = theme.vcs.changed },
            StGitDelete = { fg = theme.vcs.removed },
            FileModifiedIcon = { fg = theme.vcs.changed, bold = true },
            ErrorHl = { link = "DiagnosticError" },
            WarningHl = { link = "DiagnosticWarn" },
            HintsHl = { link = "DiagnosticHint" },
            InfoHl = { link = "DiagnosticInfo" },
            RecordingHl = { fg = theme.diag.error, bold = true },
        }
    end,
})

vim.cmd("colorscheme kanagawa-wave")
