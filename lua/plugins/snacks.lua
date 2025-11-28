return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    keys = {
        -- global
        { "<leader>e",   function() Snacks.explorer() end,                                desc = "[E]xplorer" },
        { "<leader>/",   function() Snacks.picker.grep() end,                             desc = "[/]" },

        -- search
        { "<leader>sb",  function() Snacks.picker.buffers() end,                          desc = "[S]earch [B]uffers" },
        { "<leader>sB",  function() Snacks.picker.grep_buffers() end,                     desc = "[S]earch [O]pen [B]uffers" },
        { "<leader>sf",  function() Snacks.picker.files() end,                            desc = "[S]earch [F]iles" },
        { "<leader>ss",  function() Snacks.picker.lsp_symbols() end,                      desc = "[S]earch LSP [S]ymbols" },
        { "<leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end,            desc = "[S]earch LSP Workspace [S]ymbols" },
        { "<leader>sk",  function() Snacks.picker.keymaps() end,                          desc = "[S]earch [K]eymaps" },
        { "<leader>sd",  function() Snacks.picker.diagnostics() end,                      desc = "[S]earch [D]iagnostics" },
        { "<leader>sw",  function() Snacks.picker.grep_word() end,                        desc = "[S]earch [W]ord",                 mode = { "n", "x" } },
        { "<leader>sh",  function() Snacks.picker.undo() end,                             desc = "[S]earch [H]istory" },
        { "<leader>sc",  function() Snacks.picker.resume() end,                           desc = "[S]earch [C]ontinue" },

        -- git
        { "<leader>sgb", function() Snacks.picker.git_branches() end,                     desc = "[S]earch [G]it [B]ranches" },
        { "<leader>sgl", function() Snacks.picker.git_log({ preview = "git_show", }) end, desc = "[S]earch [G]it [L]og" },
        { "<leader>sgL", function() Snacks.picker.git_log_line() end,                     desc = "[S]earch [G]it [L]og Line" },
        { "<leader>sgs", function() Snacks.picker.git_status() end,                       desc = "[S]earch [G]it [S]tatus" },
        { "<leader>sgd", function() Snacks.picker.git_diff() end,                         desc = "[S]earch [G]it [D]iff" },

        -- LSP
        { "gd",          function() Snacks.picker.lsp_definitions() end,                  desc = "Goto Definition" },
        { "gD",          function() Snacks.picker.lsp_declarations() end,                 desc = "Goto Declaration" },
        { "gr",          function() Snacks.picker.lsp_references() end,                   nowait = true,                            desc = "References" },
        { "gI",          function() Snacks.picker.lsp_implementations() end,              desc = "Goto Implementation" },
        { "gy",          function() Snacks.picker.lsp_type_definitions() end,             desc = "Goto T[y]pe Definition" },

    },
    opts = {
        explorer = { enabled = true },
        picker = {
            enabled = true,
            layout = {
                preset = "telescope",
            },
            hidden = true,
            ignored = true,
            sources = {
                explorer = {
                    tree = true,
                    watch = true,
                    diagnostics = true,
                    diagnostics_open = true,
                    git_status = true,
                    git_status_open = true,
                    git_untracked = true,
                    follow_file = true,
                    focus = "list",
                    auto_close = true,
                    layout = {
                        hidden = { "input" },
                        layout = {
                            backdrop = false,
                            row = 1,
                            width = 0.4,
                            min_width = 80,
                            height = 0.4,
                            border = true,
                            box = "vertical",
                            { win = "input",   height = 1,          border = true, title = "{title} {live} {flags}", title_pos = "center" },
                            { win = "list",    border = "hpad" },
                            { win = "preview", title = "{preview}", border = true },
                        },
                    },
                    win = {
                        list = {
                            keys = {
                                ["s"] = "edit_split",
                                ["S"] = "edit_vsplit",
                            }
                        }
                    }
                },
            },
        },
    },
}
