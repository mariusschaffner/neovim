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
        "esmuellert/codediff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
        config = function()
            require("codediff").setup({
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
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",    -- required
            "esmuellert/codediff.nvim", -- optional
            "folke/snacks.nvim",        -- optional
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "[G]it Neogit UI" },
        },
        opts = {
            sections = {
                recent = {
                    folded = false,
                },
            },
        },
    },
}
