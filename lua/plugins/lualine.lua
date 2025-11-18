return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local colors = {
            blue   = '#80a0ff',
            cyan   = '#79dac8',
            black  = '#080808',
            white  = '#c6c6c6',
            red    = '#ff5189',
            violet = '#d183e8',
            grey   = '#303030',
        }

        local bubbles_theme = {
            normal   = {
                a = { fg = colors.black, bg = colors.violet }, -- mode block
                b = { fg = colors.white, bg = 'none' },
                c = { fg = colors.white, bg = 'none' },
            },
            insert   = {
                a = { fg = colors.black, bg = colors.blue },
                b = { fg = colors.white, bg = 'none' },
                c = { fg = colors.white, bg = 'none' },
            },
            visual   = {
                a = { fg = colors.black, bg = colors.cyan },
                b = { fg = colors.white, bg = 'none' },
                c = { fg = colors.white, bg = 'none' },
            },
            replace  = {
                a = { fg = colors.black, bg = colors.red },
                b = { fg = colors.white, bg = 'none' },
                c = { fg = colors.white, bg = 'none' },
            },
            inactive = {
                a = { fg = colors.white, bg = 'none' },
                b = { fg = colors.white, bg = 'none' },
                c = { fg = colors.white, bg = 'none' },
            },
        }

        require('lualine').setup {
            options = {
                theme = bubbles_theme,
                component_separators = '',
                section_separators = { left = '', right = '|' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = {
                    'filename',
                    'branch',
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                    },
                },
                lualine_c = { '%=' },
                lualine_x = {
                    {
                        'diff',
                        symbols = { added = ' ', modified = ' ', removed = ' ' },
                    },
                    'filetype',
                },
                lualine_y = {},
                lualine_z = {
                    { '', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        }
    end,
}
