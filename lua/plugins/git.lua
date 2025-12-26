return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim", { "nvim-tree/nvim-web-devicons", opts = {} }, },
        cmd = {
            'DiffviewFileHistory', 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh'
        },
        opts = {
            enhanced_diff_hl = true,
            use_icons = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
                done = "✓",
            },
            view = {
                default = { layout = "diff2_horizontal" },
            },
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "always",
                },
                win_config = {
                    position = "left",
                    width = 40,
                    win_opts = {},
                },
            },
            file_history_panel = {
                win_config = {
                    position = "bottom",
                    height = 20,
                    win_opts = {},
                },
            },
        },
    },
    {
        'isakbm/gitgraph.nvim',
        dependencies = { 'sindrets/diffview.nvim' },
        ---@type I.GGConfig
        keys = {
            {
                "<leader>G",
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = "[G]raph",
            },
        },
        opts = {
            git_cmd = "git",
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                -- Check diff of a commit
                on_select_commit = function(commit)
                    vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
                    vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                    vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                end,
            },
        },
    },
    {
        "yutkat/git-rebase-auto-diff.nvim",
        ft = { "gitrebase" },
        opts = {
            size = vim.fn.float2nr(vim.o.lines * 0.5),
            run_show = false,
        },
    },
}
