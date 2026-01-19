return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        heading = {
            width = 'block',
            min_width = 60,
            border = true,
            border_virtual = true,
        },
        code = {
            width = 'block',
            min_width = 60,
        },
    },
}
