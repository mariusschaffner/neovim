vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

require('render-markdown').setup({
    quote = {
        repeat_linebreak = true,
    },
    checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
            scope_highlight = nil,
        },
        checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
            scope_highlight = '@markup.strikethrough',
        },
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
        scope_priority = nil,
    },
    code = {
        priority = 14,
        style = 'full',
        position = 'left',
        width = 'block',
        left_pad = 2,
        right_pad = 4,
        language_icon = true,
        language_info = true,
        Language_name = true,
        language_border = ' ',
        language_left = '█',
        language_right = '█',
        border = 'thin',
    },
    heading = {
        width = 'block',
        left_pad = 1,
        position = 'right',
        icons = { '█ ', '█ █ ', '█ █ █ ', '█ █ █ █ ', '█ █ █ █ █ ', '█ █ █ █ █ █ ', },
    }
})
