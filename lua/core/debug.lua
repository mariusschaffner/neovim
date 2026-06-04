return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'mfussenegger/nvim-dap-python'
    },
    keys = {
        { '<leader>ds', function() require('dap').continue() end,          desc = '[D]ebug: [S]tart (continue)' },
        { '<leader>di', function() require('dap').step_into() end,         desc = '[D]ebug: Step [I]nto' },
        { '<leader>do', function() require('dap').step_over() end,         desc = '[D]ebug: Step [O]ver' },
        { '<leader>dO', function() require('dap').step_out() end,          desc = '[D]ebug: Step [O]ut' },
        { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '[D]ebug: Toggle [B]reakpoint' },
        { '<leader>du', function() require('dapui').toggle() end,          desc = '[D]ebug: Toggle [U]I' },
    },
    config = function()
        local dap   = require 'dap'
        local dapui = require 'dapui'
        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = { "python" },
        }
        dapui.setup({
            layouts = {
                {
                    -- left sidebar
                    position = "left",
                    size = 40,                              -- columns wide
                    elements = {
                        { id = "scopes",      size = 0.5 }, -- local variables
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks",      size = 0.25 },
                    },
                },
                {
                    -- bottom panel
                    position = "bottom",
                    size = 12, -- rows tall
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
            local program = session.config.program -- the file being debugged
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
    end,
}
