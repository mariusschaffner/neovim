vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
    'https://github.com/nvim-tree/nvim-web-devicons',
})

require("snacks").setup({
    indent = {
        enabled = true,
        char = "│",
        animate = { enabled = false },
        scope = {
            enabled = true,
            underline = true,
        },
        chunk = {
            enabled = true,
            char = {
                corner_top = "╭",
                corner_bottom = "╰",
                horizontal = "─",
                vertical = "│",
                arrow = ">",
            },
        },
    },
    picker = {
        enabled = true,
        -- register custom layouts here, referenced by name below
        layouts = {
            stacked = {
                layout = {
                    box = "vertical",
                    width = 0.8,
                    height = 0.9,
                    border = true,
                    backdrop = false,
                    { win = "input",   height = 1,                  border = "bottom",    title = "{title} {live} {flags}", title_pos = "center" },
                    { win = "list",    title = " Results ",         title_pos = "center", border = "bottom" },
                    { win = "preview", title = "{preview:Preview}", border = false },
                },
            },
        },
        layout = {
            preset = "stacked", -- your new default, just a name now
        },
        hidden = true,
        ignored = true,
        win = {
            input = {
                keys = {
                    ["<C-s>"] = { "edit_split", mode = { "i", "n" } },
                    ["<C-t>"] = { "edit_vsplit", mode = { "i", "n" } },
                },
            },
            list = {
                keys = {
                    ["<C-s>"] = "edit_split",
                    ["<C-t>"] = "edit_vsplit",
                },
            },
        },
        sources = {
            files = {
                layout = {
                    preset = "ivy",
                    hidden = { "preview" },
                    layout = {
                        position = "bottom",
                        preview = false,
                    },
                },
                hidden = true,
                ignored = true,
                follow = true,
            },
            lines = {
                layout = {
                    preset = "ivy",
                    layout = {
                        position = "bottom",
                    },
                },
            },
            buffers = { layout = { preset = "vscode" } },
            keymaps = { layout = { preset = "vscode" } },
            diagnostics = { layout = { preset = "vscode" } },
            git_branches = { layout = { preset = "vscode" } },
        },
    },
})

local map = vim.keymap.set

-- GLOBAL
map("n", "<leader>e", function() Snacks.picker.files() end, { desc = "[E]xplorer" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "[/]" })

-- SEARCH / GREP
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "[S]earch [B]uffers" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "[S]earch [O]pen [B]uffers" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sl", function() Snacks.picker.lines() end, { desc = "[S]earch [L]ines" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "[S]earch [W]ord" })
map("n", "<leader>sh", function() Snacks.picker.undo() end, { desc = "[S]earch [H]istory" })
map("n", "<leader>sc", function() Snacks.picker.resume() end, { desc = "[S]earch [C]ontinue" })

-- GIT
map("n", "<leader>gB", function() Snacks.picker.git_branches() end, { desc = "[G]it [B]ranches" })
map("n", "<leader>gl", function() Snacks.picker.git_log({ preview = "git_show" }) end, { desc = "[G]it [L]og" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[G]it [L]og Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "[G]it [S]tatus" })

-- LSP
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "[S]earch LSP [S]ymbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = "[S]earch LSP Workspace [S]ymbols" })
