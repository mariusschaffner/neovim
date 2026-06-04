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
                        { id = "repl",    size = 0.6 },
                        { id = "console", size = 0.4 },
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

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

        require("dap-python").setup("python")
    end,
}
