vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.env.CC = "gcc"

require('vim._core.ui2').enable({})

-- filetype settings
vim.filetype.add({
    pattern = {
        ['.*%.ps1%.j2'] = 'ps1.jinja',
    },
})

-- plugins
vim.pack.add({
    -- theme
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    -- pack ui
    { src = "https://codeberg.org/cryptomilk/nvim-pack-ui" },
    -- mason
    { src = "https://github.com/mason-org/mason.nvim" },
    -- dap
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view",                    version = vim.version.range("1.*") },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
    { src = "https://github.com/mfussenegger/nvim-dap-python" },
    -- lsp / completion
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range("1.*") },
    -- git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/esmuellert/codediff.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/emrearmagan/atlas.nvim" },
    -- ui / pickers / icons
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    -- editing
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/jake-stewart/multicursor.nvim",            version = "1.0" },
    -- markdown
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    -- powershell
    { src = "https://github.com/TheLeoP/powershell.nvim" },
    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",          branch = "main",                   build = ":TSUpdate" },
    -- which-key
    { src = "https://github.com/folke/which-key.nvim" },
    -- window separator
    { src = "https://github.com/nvim-zh/colorful-winsep.nvim" },
})

-- theme
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

-- mason
require("mason").setup({})

-- dap
local dap                                  = require('dap')
require("dap").defaults.fallback.switchbuf = "usevisible,usetab,newtab"
local dapview                              = require('dap-view')

vim.keymap.set('n', '<leader>ds', function() dap.continue() end, { desc = '[D]ebug: [S]tart (continue)' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = '[D]ebug: Step [I]nto' })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = '[D]ebug: Step [O]ver' })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = '[D]ebug: Step [O]ut' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = '[D]ebug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>du', function() vim.cmd('DapViewToggle') end, { desc = '[D]ebug: Toggle [U]I' })

require('mason-nvim-dap').setup {
    -- automatic_installation = true,
    -- ensure_installed = { "python" },
    handlers = {},
}

dapview.setup({
    auto_toggle = true,
    winbar = {
        show = true,
        sections = { "watches", "scopes", "breakpoints", "threads", "repl", "console" },
        default_section = "scopes",
    },
    windows = {
        position = "left",
        size = 0.5,
    },
})

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }

for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

local function set_debug_bg()
    vim.api.nvim_set_hl(0, "NormalDebug", { bg = "#57606f" })
    local session = require("dap").session()
    if not session then return end
    local target = session.config.program or session.config.script
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if name == target then
            vim.api.nvim_win_call(win, function()
                vim.opt_local.winhighlight = "Normal:NormalDebug"
            end)
        end
    end
end

local function clear_debug_bg()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_call(win, function()
            vim.opt_local.winhighlight = ""
        end)
    end
end

local ps_term_open = false

local function find_dap_view_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "dap-view" then
            return win
        end
    end
    return nil
end

local function open_ps_term(session)
    if session.config.type ~= "ps1" or ps_term_open then return end
    vim.schedule(function()
        local dv_win = find_dap_view_win()
        local splitbelow = vim.o.splitbelow
        if dv_win then
            vim.api.nvim_set_current_win(dv_win)
            vim.o.splitbelow = true
        end
        require("powershell").toggle_debug_term()
        ps_term_open = true
        vim.wo.winfixbuf = false
        vim.o.splitbelow = splitbelow
    end)
end

local function close_ps_term(session)
    if session.config.type == "ps1" and ps_term_open then
        require("powershell").toggle_debug_term()
        ps_term_open = false
    end
end

local debug_readonly_state = {}

local function set_script_readonly()
    local session = require("dap").session()
    if not session then return end
    local target = session.config.program or session.config.script
    if not target then return end
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == target then
            debug_readonly_state[buf] = vim.bo[buf].modifiable
            vim.bo[buf].modifiable    = false
            vim.bo[buf].readonly      = true
        end
    end
end

local function clear_script_readonly()
    for buf, was_modifiable in pairs(debug_readonly_state) do
        if vim.api.nvim_buf_is_valid(buf) then
            vim.bo[buf].modifiable = was_modifiable
            vim.bo[buf].readonly   = false
        end
    end
    debug_readonly_state = {}
end

dap.listeners.after.event_initialized["debug_bg"]        = set_debug_bg
dap.listeners.after.event_initialized["ps_debug_term"]   = open_ps_term
dap.listeners.after.event_initialized["script_readonly"] = set_script_readonly
dap.listeners.before.event_terminated["debug_bg"]        = clear_debug_bg
dap.listeners.before.event_terminated["ps_debug_term"]   = close_ps_term
dap.listeners.before.event_terminated["script_readonly"] = clear_script_readonly
dap.listeners.before.event_exited["debug_bg"]            = clear_debug_bg
dap.listeners.before.event_exited["ps_debug_term"]       = close_ps_term
dap.listeners.before.event_exited["script_readonly"]     = clear_script_readonly

-- require("dap-python").setup("python")
-- powershell is enabled by powershell.nvim plugin

-- lsp
require("fidget").setup({})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config('*', {
    capabilities = capabilities,
})

local servers = {
    lua_ls = {},
    yamlls = {},
    terraformls = {},
    basedpyright = {},
    powershell_es = {},
    ansiblels = {
        settings = {
            ansible = {
                validation = {
                    lint = {
                        enabled = false,
                    },
                },
            },
        },
    },
}

for name, cfg in pairs(servers) do
    if next(cfg) ~= nil then
        vim.lsp.config(name, cfg)
    end
end

require("mason-lspconfig").setup({
    -- ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
})

-- git
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

local function current_gitlab_project()
    local remote = vim.fn.systemlist("git config --get remote.origin.url")[1]
    if not remote or remote == "" then
        return nil
    end

    local path = remote:match("^git@[^:]+:(.+)$")

    if not path then
        path = remote:match("^https?://[^/]+/(.+)$")
    end

    if not path then
        return nil
    end

    return (path:gsub("%.git$", ""))
end

local project = current_gitlab_project()

local pulls_views = {
    { name = "Assigned to Me", key = "1", order_by = "updated_at", state = "open", scope = "assigned_to_me", project = project },
    { name = "Reviewing",      key = "2", order_by = "updated_at", state = "open", scope = "all",            project = project, extra_params = { reviewer_id = "133" } },
    { name = "Open",           key = "3", order_by = "updated_at", state = "open", project = project },
}

require("atlas").setup({
    pulls = {
        diff = {
            open_cmd = "AtlasDiff",
            layout = "inline",
            compact = false,
            explorer = {
                hidden = false,
                show_commits = true,
            },
        },
        providers = {
            gitlab = {
                base_url = "https://gitlab.vertec.com",
                token = vim.env.GITLAB_TOKEN,
                cache_ttl = 300,
                views = pulls_views,
            },
        },
    },
    issues = {
        providers = {
            gitlab = {
                base_url = "https://gitlab.vertec.com",
                token = vim.env.GITLAB_TOKEN,
                cache_ttl = 300,
                views = {
                    -- { name = "Assigned to Me", key = "1", scope = "assigned_to_me", state = "opened", order_by = "updated_at" },
                    { name = "WF:Doing",      key = "2", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Doing" } },
                    { name = "WF:Review",     key = "3", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Review" } },
                    { name = "WF:Deployment", key = "4", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Deployment" } },
                    { name = "All",           key = "5", scope = "all",            state = "opened", order_by = "updated_at" },
                },
            },
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

-- snacks / picker
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
            preset = "stacked",
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
                exclude = { ".git", "venv", ".terraform" }
            },
            grep = {
                exclude = { ".git", "venv", ".terraform" }
            },
            grep_word = {
                exclude = { ".git", "venv", ".terraform" }
            },
            buffers = { layout = { preset = "vscode" } },
            keymaps = { layout = { preset = "vscode" } },
            diagnostics = { layout = { preset = "vscode" } },
            git_branches = { layout = { preset = "vscode" } },
        },
    },
})

local map = vim.keymap.set

map("n", "<leader>e", function() Snacks.picker.files() end, { desc = "[E]xplorer" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "[/]" })
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "[S]earch [B]uffers" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "[S]earch [O]pen [B]uffers" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "[S]earch [D]iagnostics" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "[S]earch [W]ord" })
map("n", "<leader>sh", function() Snacks.picker.undo() end, { desc = "[S]earch [H]istory" })
map("n", "<leader>sc", function() Snacks.picker.resume() end, { desc = "[S]earch [C]ontinue" })
map("n", "<leader>gB", function() Snacks.picker.git_branches() end, { desc = "[G]it [B]ranches" })
map("n", "<leader>gl", function() Snacks.picker.git_log({ preview = "git_show" }) end, { desc = "[G]it [L]og" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[G]it [L]og Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "[G]it [S]tatus" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "[S]earch LSP [S]ymbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = "[S]earch LSP Workspace [S]ymbols" })

-- autocmds
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local lmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        lmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        lmap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        lmap('n', 'gr', vim.lsp.buf.references, 'Find references')
        lmap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        lmap('n', 'K', vim.lsp.buf.hover, 'Hover docs')
        lmap('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        lmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        lmap('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, 'Format buffer')

        -- Inlay hints
        if client and client:supports_method('textDocument/inlayHint', ev.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            lmap('n', '<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, '[T]oggle inlay [H]ints')
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yml", "*.yaml" },
    desc = "Set Ansible filetype for YAML files",
    group = vim.api.nvim_create_augroup("ansible-yaml", { clear = true }),
    callback = function()
        vim.bo.filetype = "yaml.ansible"
    end,
})

-- autopairs
require("nvim-autopairs").setup({})

-- completion (blink.cmp)
require("blink.cmp").setup({
    keymap = {
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        menu = {
            scrollbar = false,
            border = "rounded",
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind",              gap = 1 },
                },
                components = {
                    label = {
                        width = { fill = true, max = 60 },
                        text = function(ctx) return ctx.label end,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = true,
            window = {
                scrollbar = false,
                border = "rounded",
            },
        },
    },
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "lua" },
    signature = { enabled = false },
})

-- formatting (conform)
require("conform").setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        local disable_filetypes = { ps1 = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
        else
            return {
                timeout_ms = 500,
                lsp_format = "fallback",
            }
        end
    end,
    formatters_by_ft = {
        lua = { "stylua" },
    },
})

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- keymaps
local keymap = vim.keymap.set
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlights",
})
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
keymap("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
keymap("n", "<C-A-h>", "<cmd>vertical resize -2<CR>", {
    desc = "Resize split left",
    silent = true,
})
keymap("n", "<C-A-l>", "<cmd>vertical resize +2<CR>", {
    desc = "Resize split right",
    silent = true,
})
keymap("n", "<C-A-j>", "<cmd>resize -2<CR>", {
    desc = "Resize split down",
    silent = true,
})
keymap("n", "<C-A-k>", "<cmd>resize +2<CR>", {
    desc = "Resize split up",
    silent = true,
})
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", {
    desc = "Move line down",
})
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", {
    desc = "Move line up",
})
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", {
    desc = "Move selection down",
})
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", {
    desc = "Move selection up",
})
keymap("n", "<leader>wn", "<cmd>bn<CR>", {
    desc = "Next buffer",
})
keymap("n", "<leader>wp", "<cmd>bp<CR>", {
    desc = "Previous buffer",
})
keymap("n", "<leader>ws", function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    local open_buffers = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        open_buffers[vim.api.nvim_win_get_buf(win)] = true
    end
    for _, buf in ipairs(buffers) do
        if not open_buffers[buf.bufnr] then
            vim.cmd("vsplit")
            vim.cmd("buffer " .. buf.bufnr)
        end
    end
end, {
    desc = "Split all buffers vertically",
})
keymap("n", "<leader>wm", "<cmd>only<CR>", {
    desc = "Maximize current buffer",
})
keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })
keymap("n", "<leader>gd", ":CodeDiff<CR>", { desc = "[G]it [D]iff" })
keymap("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "[G]it [b]lame" })
keymap("n", "<leader>gi", ":Atlas issues<CR>", { desc = "[G]itlab [i]ssues" })
keymap("n", "<leader>gm", ":Atlas pulls<CR>", { desc = "[G]itlab [m]erge_requests" })

-- markdown
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

-- multicursor
local mc = require("multicursor-nvim")
mc.setup()
local mc_set = vim.keymap.set

mc_set({ "n", "x" }, "<C-Up>", function() mc.lineAddCursor(-1) end)
mc_set({ "n", "x" }, "<C-Down>", function() mc.lineAddCursor(1) end)
mc_set({ "n", "x" }, "<A-Up>", function() mc.lineSkipCursor(-1) end)
mc_set({ "n", "x" }, "<A-Down>", function() mc.lineSkipCursor(1) end)

mc.addKeymapLayer(function(layerSet)
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

local mc_hl = vim.api.nvim_set_hl
mc_hl(0, "MultiCursorCursor", { reverse = true })
mc_hl(0, "MultiCursorVisual", { link = "Visual" })
mc_hl(0, "MultiCursorSign", { link = "SignColumn" })
mc_hl(0, "MultiCursorMatchPreview", { link = "Search" })
mc_hl(0, "MultiCursorDisabledCursor", { reverse = true })
mc_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
mc_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

-- options
vim.opt.laststatus = 1
vim.opt.cmdheight = 0
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪  "
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 15
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.colorcolumn = "90"
vim.opt.fillchars = {
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
}
vim.o.winborder = 'rounded'
vim.opt.confirm = true
vim.opt.diffopt:append("vertical")
vim.opt.diffopt:append("linematch:60")

-- powershell
require('powershell').setup({
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
})

-- statusline
local function get_mode()
    local mode_map = {
        n = { " n ", "StModeNormal" },
        i = { " i ", "StModeInsert" },
        v = { " v ", "StModeVisual" },
        V = { " v-line ", "StModeVisual" },
        ["\22"] = { " v-block ", "StModeVisual" },
        c = { " c ", "StModeOther" },
        r = { " r ", "StModeOther" },
        R = { " R ", "StModeOther" },
        t = { " t ", "StModeOther" },
    }
    local mode = vim.api.nvim_get_mode().mode
    local m = mode_map[mode] or { " " .. mode .. " ", "StModeOther" }
    return "%#" .. m[2] .. "#" .. m[1] .. "%#StBase#"
end

local function get_git()
    local dict = vim.b.gitsigns_status_dict
    if not dict then
        return ""
    end

    local branch = dict.head and ("%#StGitBranch#  " .. dict.head .. " ") or ""
    local added = dict.added and dict.added > 0 and ("%#StGitAdd#+" .. dict.added .. " ") or ""
    local changed = dict.changed and dict.changed > 0 and ("%#StGitChange#~" .. dict.changed .. " ") or ""
    local removed = dict.removed and dict.removed > 0 and ("%#StGitDelete#-" .. dict.removed .. " ") or ""

    local diff = added .. changed .. removed
    if branch == "" and diff == "" then
        return ""
    end
    return branch .. diff .. ""
end

local function get_lsp_diagnostic_count()
    local counts = vim.diagnostic.count(0)

    local errors = counts[vim.diagnostic.severity.ERROR] or 0
    local warnings = counts[vim.diagnostic.severity.WARN] or 0
    local hints = counts[vim.diagnostic.severity.HINT] or 0
    local info = counts[vim.diagnostic.severity.INFO] or 0

    local error_icon = errors > 0 and "  " .. errors or ""
    local warnings_icon = warnings > 0 and "  " .. warnings or ""
    local hints_icon = hints > 0 and "  " .. hints or ""
    local info_icon = info > 0 and "  " .. info or ""

    return "%#ErrorHl#"
        .. error_icon
        .. "%#WarningHl#"
        .. warnings_icon
        .. "%#HintsHl#"
        .. hints_icon
        .. "%#InfoHl#"
        .. info_icon
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
local function get_icon()
    if not has_devicons then
        return ""
    end
    local icon, icon_hl = devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"))
    if not icon then
        return ""
    end
    return "%#" .. icon_hl .. "# " .. icon .. " %#StBase#"
end

local blink_icon = true
local blink_timer = nil

local function get_macro_reading()
    local is_rec = vim.fn.reg_recording()
    if is_rec == "" then
        if blink_timer then
            blink_timer:stop()
            blink_timer:close()
            blink_timer = nil
        end
        return ""
    end
    if not blink_timer then
        blink_timer = vim.uv.new_timer()
        blink_timer:start(
            0,
            500,
            vim.schedule_wrap(function()
                blink_icon = not blink_icon
                vim.cmd("redrawstatus")
            end)
        )
    end
    local icon = blink_icon and "" or " "
    return "%#RecordingHl#" .. icon .. "%#StBase#" .. " Rec @"
end

function _G.CustomStatusLine()
    local is_active = vim.g.statusline_winid == vim.fn.win_getid()
    local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
    local modified_icon = is_modified and "●" or ""
    local filename = " %t"
    local space = "%="
    if not is_active then
        return "%#StBase#" .. filename .. space
    end
    return "%#StBase# "
        .. "%#StBase#"
        .. get_mode()
        .. filename
        .. " "
        .. get_lsp_diagnostic_count()
        .. get_git()
        .. "%#StBase#"
        .. space
        .. get_macro_reading()
        .. space
        .. get_icon()
end

vim.opt.statusline = "%!v:lua.CustomStatusLine()"

vim.cmd("redrawstatus")

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "CmdlineLeave" }, {
    callback = function()
        vim.schedule(function()
            vim.cmd("redrawstatus")
        end)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = { "GitSignsUpdate" },
    callback = function()
        vim.cmd("redrawstatus")
    end,
})

-- treesitter
local treesitter = require("nvim-treesitter")
treesitter.setup({})

local ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "json",
    "python",
    "powershell",
    "terraform",
    "yaml",
    "markdown",
    "markdown_inline",
    "csv",
    "dockerfile",
    "gitignore",
}

local ts_config = require("nvim-treesitter.config")
local already_installed = ts_config.get_installed()
local parsers_to_install = {}

for _, parser in ipairs(ensure_installed) do
    if not vim.tbl_contains(already_installed, parser) then
        table.insert(parsers_to_install, parser)
    end
end

-- if #parsers_to_install > 0 then
-- 	treesitter.install(parsers_to_install)
-- end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
    callback = function(args)
        if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
            vim.treesitter.start(args.buf)
        end
    end,
})

-- which-key
require("which-key").setup({
    preset = "helix",
    delay = 0,
    icons = {
        mappings = false,
        keys = vim.g.have_nerd_font and {} or {
            Up = "",
            Down = "",
            Left = "",
            Right = "",
            C = "<C-…> ",
            M = "<M-…> ",
            D = "<D-…> ",
            S = "<S-…> ",
            CR = "<CR> ",
            Esc = "󱊷",
            ScrollWheelDown = "<ScrollWheelDown> ",
            ScrollWheelUp = "<ScrollWheelUp> ",
            NL = "<NL> ",
            BS = "󰁮",
            Space = "󱁐",
            Tab = "󰌒",
            F1 = "<F1>",
            F2 = "<F2>",
            F3 = "<F3>",
            F4 = "<F4>",
            F5 = "<F5>",
            F6 = "<F6>",
            F7 = "<F7>",
            F8 = "<F8>",
            F9 = "<F9>",
            F10 = "<F10>",
            F11 = "<F11>",
            F12 = "<F12>",
        },
    },
    spec = {
        { "<leader>s",  group = "[S]earch" },
        { "<leader>sg", group = "[S]earch [G]it" },
        { "<leader>g",  group = "[G]it" },
        { "<leader>w",  group = "[W]indow" },
        { "<leader>R",  group = "[R]est Client" },
        { "<leader>d",  group = "[D]ebug" },
    },
})

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "[?] Buffer Local Keymaps" })

-- window separator
require('colorful-winsep').setup({
    border = "rounded",
    animate = {
        enabled = false,
    },
    indicator_for_2wins = {
        position = "both",
        symbols = {
            start_left = "󱞬",
            end_left = "󱞪",
            start_down = "󱞾",
            end_down = "󱟀",
            start_up = "󱞢",
            end_up = "󱞤",
            start_right = "󱞨",
            end_right = "󱞦",
        },
    },
})
