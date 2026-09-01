vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view",       version = vim.version.range("1.*") },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
    { src = "https://github.com/mfussenegger/nvim-dap-python" },
})

local dap                                  = require('dap')
require("dap").defaults.fallback.switchbuf = "usevisible,usetab,newtab"
local dapview                              = require('dap-view')

vim.keymap.set('n', '<leader>ds', function() dap.continue() end, { desc = '[D]ebug: [S]tart (continue)' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = '[D]ebug: Step [I]nto' })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = '[D]ebug: Step [O]ver' })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = '[D]ebug: Step [O]ut' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = '[D]ebug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>du', function() vim.cmd('DapViewToggle') end, { desc = '[D]ebug: Toggle [U]I' })

require('mason').setup({})
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
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }

for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

local debug_hl_ns = vim.api.nvim_create_namespace("dap_debug_bg")

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
