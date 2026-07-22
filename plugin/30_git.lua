vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/esmuellert/codediff.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/folke/snacks.nvim" }, -- already added in snacks.lua; vim.pack will no-op the dupe
})

require("gitsigns").setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
})

require("codediff").setup({
    keymaps = {
        view = {
            quit = "q",
            toggle_explorer = "<leader>b",
            next_hunk = "]c",
            prev_hunk = "[c",
            next_file = "<Tab>",
            prev_file = "<S-Tab>",
        },
        explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
        },
    },
})

require("neogit").setup({
    graph_style = "unicode",
    sections = {
        recent = {
            folded = false,
        },
    },
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "[G]it Neogit UI" })
