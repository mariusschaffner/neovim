-- ============================================================================
-- 1. Globals
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.env.CC = "gcc"

require("vim._core.ui2").enable({})

-- ============================================================================
-- 2. Options
-- ============================================================================
local opt = vim.opt
opt.laststatus = 2
opt.cmdheight = 0
opt.signcolumn = "yes"
opt.cursorline = true
opt.colorcolumn = "90"
opt.scrolloff = 10
opt.lazyredraw = true
opt.winborder = "rounded"
opt.list = true
opt.listchars = { tab = "» ", trail = " ", nbsp = "␣" }
opt.fillchars = { horiz = "─", horizup = "┴", horizdown = "┬" }
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪  "
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.splitright = true
opt.splitbelow = true
opt.diffopt:append("vertical")
opt.diffopt:append("linematch:60")
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.confirm = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 15

vim.schedule(function()
    opt.clipboard = "unnamedplus"
end)

-- ============================================================================
-- 3. Filetypes
-- ============================================================================
vim.filetype.add({
    extension = {
        yml = "yaml.ansible",
        yaml = "yaml.ansible",
    },
    pattern = {
        [".*%.ps1%.j2"] = "ps1.jinja",
    },
})

-- ============================================================================
-- 4. Plugins
-- ============================================================================
vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://codeberg.org/cryptomilk/nvim-pack-ui" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                version = vim.version.range("1.*") },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main",                   build = ":TSUpdate" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/esmuellert/codediff.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/mariusschaffner/atlas.nvim" },
    { src = "https://github.com/mariusschaffner/git.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-zh/colorful-winsep.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/jake-stewart/multicursor.nvim",   version = "1.0" },
})

-- ============================================================================
-- 5. Colorscheme
-- ============================================================================
require("kanagawa").setup({
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    overrides = function(colors)
        local theme = colors.theme
        return {
            ["@lsp.type.variable.ps1"] = { fg = "#ef596e" },
            Normal = { fg = "#FFFEFE" },
            CursorLine = { bg = "#3e4452" },
            Visual = { bg = "#4b6584" },
            ColorfulWinSep = { fg = "#ffa502" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { fg = "#00f2ff", bg = "NONE" },
            FloatTitle = { bg = "NONE" },
            PMenu = { bg = "NONE" },
            BlinkCmpMenu = { bg = "NONE" },
            BlinkCmpMenuBorder = { fg = "#00f2ff", bg = "NONE" },
            BlinkCmpDocBorder = { fg = "#820857", bg = "NONE" },
            BlinkCmpLabelMatch = { bg = "NONE" },
            StatusLine = { bg = "NONE" },
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
            MultiCursorCursor = { reverse = true },
            MultiCursorVisual = { link = "Visual" },
            MultiCursorSign = { link = "SignColumn" },
            MultiCursorMatchPreview = { link = "Search" },
            MultiCursorDisabledCursor = { reverse = true },
            MultiCursorDisabledVisual = { link = "Visual" },
            MultiCursorDisabledSign = { link = "SignColumn" },
        }
    end,
})
vim.cmd.colorscheme("kanagawa-wave")

-- ============================================================================
-- 6. Plugins
-- ============================================================================
local exclude = { ".git", "venv", ".terraform" }
local vscode = { layout = { preset = "vscode" } }
require("snacks").setup({
    indent = {
        enabled = true,
        char = "│",
        animate = { enabled = false },
        scope = { enabled = true, underline = true },
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
        hidden = true,
        ignored = true,
        layout = { preset = "stacked" },
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
                    layout = { position = "bottom", preview = false },
                },
                hidden = true,
                ignored = true,
                follow = true,
                exclude = exclude,
            },
            grep = { exclude = exclude },
            grep_word = { exclude = exclude },
            buffers = vscode,
            keymaps = vscode,
            diagnostics = vscode,
            git_branches = vscode,
        },
    },
})

require("colorful-winsep").setup({
    border = "rounded",
    animate = { enabled = false },
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

require("nvim-autopairs").setup({})

require("conform").setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        local disabled = { ps1 = true }
        if disabled[vim.bo[bufnr].filetype] then
            return nil
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
    },
})

local mc = require("multicursor-nvim")
mc.setup()
mc.addKeymapLayer(function(layerSet)
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

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
    appearance = { nerd_font_variant = "mono" },
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
            window = { scrollbar = false, border = "rounded" },
        },
    },
    sources = { default = { "lsp", "path", "buffer" } },
    fuzzy = { implementation = "lua" },
    signature = { enabled = false },
})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    underline = true,
    float = { border = "rounded", source = "if_many" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})
local servers = {
    lua_ls = {},
    yamlls = {},
    terraformls = {},
    basedpyright = {},
    powershell_es = {},
    ansiblels = {
        settings = {
            ansible = { validation = { lint = { enabled = false } } },
        },
    },
}
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
for name, cfg in pairs(servers) do
    if next(cfg) ~= nil then
        vim.lsp.config(name, cfg)
    end
end
require("mason").setup({})
require("mason-lspconfig").setup({
    -- ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
})

local treesitter = require("nvim-treesitter")
treesitter.setup({})
treesitter.install({
    "lua", "vim", "vimdoc", "json", "python", "powershell", "terraform",
    "yaml", "markdown", "markdown_inline", "csv", "dockerfile", "gitignore",
})

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

require("codediff").setup({
    highlights = {
        line_insert = "#2B3328",
        line_delete = "#43242B",
        char_insert = "#3D5A3A",
        char_delete = "#6E2F3A",
    },
})

require("neogit").setup({
    graph_style = "unicode",
    disable_hint = true,
    sections = {
        recent = { folded = false },
        stashes = { folded = false },
        unpulled_pushRemote = { folded = false },
        rebase = { folded = false },
    },
})

local gitlab_view = { name = "All", key = "1", scope = "all", current_repo = true, order_by = "updated_at" }
require("atlas").setup({
    ui = { listed_buffer = true },
    providers = {
        gitlab = {
            base_url = "https://gitlab.vertec.com",
            token = vim.env.GITLAB_TOKEN,
            cache_ttl = 300,
        },
    },
    pulls = {
        diff = {
            open_cmd = "CodeDiff",
            layout = "inline",
            compact = true,
            explorer = { hidden = false, show_commits = true },
        },
        gitlab = { views = { vim.tbl_extend("force", gitlab_view, { state = "open" }) } },
    },
    issues = {
        gitlab = { views = { vim.tbl_extend("force", gitlab_view, { state = "opened" }) } },
    },
})

local Statusline = {}
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
function Statusline.mode()
    local mode = vim.api.nvim_get_mode().mode
    local m = mode_map[mode] or { " " .. mode .. " ", "StModeOther" }
    return "%#" .. m[2] .. "#" .. m[1] .. "%#StBase#"
end

function Statusline.git()
    local dict = vim.b.gitsigns_status_dict
    if not dict then
        return ""
    end
    local function part(hl, prefix, n)
        return (n and n > 0) and ("%#" .. hl .. "#" .. prefix .. n .. " ") or ""
    end
    local branch = dict.head and ("%#StGitBranch#  " .. dict.head .. " ") or ""
    return branch
        .. part("StGitAdd", "+", dict.added)
        .. part("StGitChange", "~", dict.changed)
        .. part("StGitDelete", "-", dict.removed)
end

function Statusline.diagnostics()
    local counts = vim.diagnostic.count(0)
    local sev = vim.diagnostic.severity
    local function part(hl, icon, n)
        n = n or 0
        return "%#" .. hl .. "#" .. (n > 0 and (icon .. n) or "")
    end
    return part("ErrorHl", "  ", counts[sev.ERROR])
        .. part("WarningHl", "  ", counts[sev.WARN])
        .. part("HintsHl", "  ", counts[sev.HINT])
        .. part("InfoHl", "  ", counts[sev.INFO])
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
function Statusline.icon()
    if not has_devicons then
        return ""
    end
    local icon, icon_hl = devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"))
    if not icon then
        return ""
    end
    return "%#" .. icon_hl .. "# " .. icon .. " %#StBase#"
end

local blink_on, blink_timer = true, nil
function Statusline.macro()
    if vim.fn.reg_recording() == "" then
        if blink_timer then
            blink_timer:stop()
            blink_timer:close()
            blink_timer = nil
        end
        return ""
    end
    if not blink_timer then
        blink_timer = vim.uv.new_timer()
        blink_timer:start(0, 500, vim.schedule_wrap(function()
            blink_on = not blink_on
            vim.cmd.redrawstatus()
        end))
    end
    local icon = blink_on and "" or " "
    return "%#RecordingHl#" .. icon .. "%#StBase# Rec @"
end

function _G.CustomStatusLine()
    local filename = " %t"
    if vim.g.statusline_winid ~= vim.fn.win_getid() then
        return "%#StBase#" .. filename .. "%="
    end
    return "%#StBase# "
        .. Statusline.mode()
        .. filename
        .. " "
        .. Statusline.diagnostics()
        .. Statusline.git()
        .. "%#StBase#%="
        .. Statusline.macro()
        .. "%="
        .. Statusline.icon()
end

opt.statusline = "%!v:lua.CustomStatusLine()"

-- ============================================================================
-- 13. Keymaps
-- ============================================================================
local map = vim.keymap.set
local function picker(name, opts)
    return function() Snacks.picker[name](opts) end
end
local function split_all_buffers()
    local open = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        open[vim.api.nvim_win_get_buf(win)] = true
    end
    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if not open[buf.bufnr] then
            vim.cmd("vsplit")
            vim.cmd("buffer " .. buf.bufnr)
        end
    end
end
local keys = {
    { "n",          "<leader>e",  picker("files"),                       "[E]xplorer" },
    { "n",          "<leader>/",  picker("grep"),                        "[/] Search" },
    { "n",          "<leader>sb", picker("buffers"),                     "[S]earch [B]uffers" },
    { "n",          "<leader>sd", picker("diagnostics"),                 "[S]earch [D]iagnostics" },
    { { "n", "x" }, "<leader>sw", picker("grep_word"),                   "[S]earch [W]ord" },
    { "n",          "<leader>sc", picker("resume"),                      "[S]earch [C]ontinue" },
    { "n",          "<leader>?",  picker("keymaps", { global = false }), "[?] Buffer local keymaps" },
    { "n",          "gd",         picker("lsp_definitions"),             "Goto Definition" },
    { "n",          "gD",         picker("lsp_declarations"),            "Goto Declaration" },
    { "n",          "gr",         picker("lsp_references"),              "References",              { nowait = true } },
    { "n",          "gI",         picker("lsp_implementations"),         "Goto Implementation" },
    { "n",          "gy",         picker("lsp_type_definitions"),        "Goto T[y]pe Definition" },
    { "n",          "<leader>gg", "<cmd>Neogit<cr>",                     "[G]it UI" },
    { "n",          "<leader>gd", "<cmd>CodeDiff<cr>",                   "[G]it [D]iff" },
    { "n",          "<leader>gb", "<cmd>Gitsigns blame<cr>",             "[G]it [b]lame" },
    { "n",          "<leader>G",  "<cmd>Atlas issues<cr>",               "[G]itlab" },
    { "n", "<leader>f", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
    end, "[F]ormat buffer" },
    { "n",          "<Esc>",      "<cmd>nohlsearch<cr>",                "Clear search highlights" },
    { "n",          "<A-j>",      "<cmd>m .+1<cr>==",                   "Move line down" },
    { "n",          "<A-k>",      "<cmd>m .-2<cr>==",                   "Move line up" },
    { "v",          "<A-j>",      ":m '>+1<cr>gv=gv",                   "Move selection down",         { silent = true } },
    { "v",          "<A-k>",      ":m '<-2<cr>gv=gv",                   "Move selection up",           { silent = true } },
    { { "n", "x" }, "<C-Up>",     function() mc.lineAddCursor(-1) end,  "Add cursor above" },
    { { "n", "x" }, "<C-Down>",   function() mc.lineAddCursor(1) end,   "Add cursor below" },
    { { "n", "x" }, "<A-Up>",     function() mc.lineSkipCursor(-1) end, "Skip cursor above" },
    { { "n", "x" }, "<A-Down>",   function() mc.lineSkipCursor(1) end,  "Skip cursor below" },
    { "n",          "<C-h>",      "<C-w>h",                             "Focus left window" },
    { "n",          "<C-l>",      "<C-w>l",                             "Focus right window" },
    { "n",          "<C-j>",      "<C-w>j",                             "Focus lower window" },
    { "n",          "<C-k>",      "<C-w>k",                             "Focus upper window" },
    { "n",          "<C-A-h>",    "<cmd>vertical resize -2<cr>",        "Resize split left",           { silent = true } },
    { "n",          "<C-A-l>",    "<cmd>vertical resize +2<cr>",        "Resize split right",          { silent = true } },
    { "n",          "<C-A-j>",    "<cmd>resize -2<cr>",                 "Resize split down",           { silent = true } },
    { "n",          "<C-A-k>",    "<cmd>resize +2<cr>",                 "Resize split up",             { silent = true } },
    { "n",          "<leader>wn", "<cmd>bn<cr>",                        "Next buffer" },
    { "n",          "<leader>wp", "<cmd>bp<cr>",                        "Previous buffer" },
    { "n",          "<leader>ws", split_all_buffers,                    "Split all buffers vertically" },
    { "n",          "<leader>wm", "<cmd>only<cr>",                      "Maximize current buffer" },
    { "n",          "<leader>dd", vim.diagnostic.open_float,            "Show diagnostic" },
    { "n",          "<leader>dl", vim.diagnostic.setloclist,            "Diagnostic list" },
}
for _, k in ipairs(keys) do
    map(k[1], k[2], k[3], vim.tbl_extend("force", { desc = k[4] }, k[5] or {}))
end
for key, hint in pairs({ left = "h", right = "l", up = "k", down = "j" }) do
    map("n", "<" .. key .. ">", '<cmd>echo "Use ' .. hint .. ' to move!!"<cr>')
end

-- ============================================================================
-- 14. Autocommands
-- ============================================================================
local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end
autocmd("LspAttach", {
    group = augroup("lsp-attach"),
    callback = function(ev)
        local function lmap(lhs, rhs, desc)
            map("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end
        lmap("K", vim.lsp.buf.hover, "Hover docs")
        lmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame symbol")
        lmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/inlayHint", ev.buf) then
            vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
            lmap("<leader>th", function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
            end, "[T]oggle inlay [H]ints")
        end
    end,
})

autocmd("FileType", {
    group = augroup("treesitter-start"),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and vim.list_contains(treesitter.get_installed(), lang) then
            vim.treesitter.start(args.buf)
        end
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = augroup("highlight-yank"),
    callback = function() vim.hl.on_yank() end,
})

local statusline_group = augroup("statusline-redraw")
autocmd({ "InsertEnter", "InsertLeave", "CmdlineLeave" }, {
    group = statusline_group,
    callback = function() vim.schedule(vim.cmd.redrawstatus) end,
})

autocmd("User", {
    group = statusline_group,
    pattern = "GitSignsUpdate",
    callback = function() vim.cmd.redrawstatus() end,
})
