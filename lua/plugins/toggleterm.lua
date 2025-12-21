return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shading_factor = 0,
        shading_ratio = 0,
        direction = "float",
        open_mapping = [[<M-t>]],
        shell = "pwsh",
        float_opts = {
            border = "curved",
            width = function()
                return vim.o.columns
            end,
            height = function()
                return vim.o.lines
            end,
        },
        highlights = {
            FloatBoarder = "#00f2ff",
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Custom scooter terminal logic
        local Terminal = require("toggleterm.terminal").Terminal
        local scooter_term = nil
        local tftui_term = nil

        local function open_scooter()
            if not scooter_term then
                scooter_term = Terminal:new({
                    cmd = "scooter --hidden --case-insensitive --files-to-include *",
                    direction = "float",
                    close_on_exit = true,
                    on_exit = function()
                        scooter_term = nil
                    end,
                })
            end
            scooter_term:open()
        end
        vim.keymap.set("n", "<leader>sr", open_scooter, { desc = "[S]earch and [R]eplace" })

        local function find_envs()
            local cwd = vim.fn.getcwd()
            local env_root = cwd .. "/env"
            local dirs = vim.fn.glob(env_root .. "/*", 1, 1)

            local env_map = {}
            local names = {}

            for _, d in ipairs(dirs) do
                if vim.fn.isdirectory(d) == 1 then
                    local name = vim.fn.fnamemodify(d, ":t") -- folder name only
                    env_map[name] = d
                    table.insert(names, name)
                end
            end

            return names, env_map
        end

        local function open_tftui()
            local names, env_map = find_envs()
            if #names == 0 then
                vim.notify("No env folders found", vim.log.levels.ERROR)
                return
            end

            vim.ui.select(names, { prompt = "Select environment" }, function(selected)
                if not selected then return end

                local full_path = env_map[selected]
                if not full_path then
                    vim.notify("Env path not found", vim.log.levels.ERROR)
                    return
                end

                tftui_term = Terminal:new({
                    cmd = "pwsh -Command \"Import-EnvVars; cd " .. full_path .. ";terraform init; tftui -d;  exit\"",
                    direction = "float",
                    close_on_exit = true,
                    on_exit = function()
                        tftui_term = nil
                    end,
                })

                tftui_term:open()
            end)
        end
        vim.keymap.set("n", "<leader>ts", open_tftui, { desc = "[T]erraform [S]tate" })
    end,
}
