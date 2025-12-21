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
        {
            "esmuellert/vscode-diff.nvim",
            dependencies = { "MunifTanjim/nui.nvim" },
            cmd = "CodeDiff",
            config = function()
                require("vscode-diff").setup({
                    -- Keymaps in diff view
                    keymaps = {
                        view = {
                            quit = "q",                    -- Close diff tab
                            toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
                            next_hunk = "]c",              -- Jump to next change
                            prev_hunk = "[c",              -- Jump to previous change
                            next_file = "<Tab>",           -- Next file in explorer mode
                            prev_file = "<S-Tab>",         -- Previous file in explorer mode
                        },
                        explorer = {
                            select = "<CR>", -- Open diff for selected file
                            hover = "K",     -- Show file diff preview
                            refresh = "R",   -- Refresh git status
                        },
                    },
                })
            end,
        }
    },
    {
        'isakbm/gitgraph.nvim',
        dependencies = { 'sindrets/diffview.nvim' },
        ---@type I.GGConfig
        keys = {
            {
                "<leader>gg",
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = "[G]it [G]raph",
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
                    vim.notify('CodeDiff ' .. commit.hash)
                    vim.cmd(':CodeDiff ' .. commit.hash)
                end,
            },
        },
    },
}
