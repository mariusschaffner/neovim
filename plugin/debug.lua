-- lua/plugins/dap.lua

vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap-python" },
})

local dap   = require('dap')
local dapui = require('dapui')

-- keymaps (previously `keys` in the lazy spec)
vim.keymap.set('n', '<leader>ds', function() dap.continue() end, { desc = '[D]ebug: [S]tart (continue)' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = '[D]ebug: Step [I]nto' })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = '[D]ebug: Step [O]ver' })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = '[D]ebug: Step [O]ut' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = '[D]ebug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = '[D]ebug: Toggle [U]I' })

-- previously the `config` function body, unchanged
require('mason').setup({}) -- mason itself needs setup() now too, since vim.pack has no opts={} shorthand
require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = { "python" },
}

dapui.setup({
  layouts = {
    {
      position = "left",
      size = 40,
      elements = {
        { id = "scopes",      size = 0.5 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks",      size = 0.25 },
      },
    },
    {
      position = "bottom",
      size = 12,
      elements = {
        { id = "repl",    size = 0.4 },
        { id = "console", size = 0.6 },
      },
    },
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
  local program = session.config.program
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == program then
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

dap.listeners.after.event_initialized["debug_bg"]     = set_debug_bg
dap.listeners.before.event_terminated["debug_bg"]     = clear_debug_bg
dap.listeners.before.event_exited["debug_bg"]         = clear_debug_bg
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

require("dap-python").setup("python")
