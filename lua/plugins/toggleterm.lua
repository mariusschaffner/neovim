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
            width = 150,
            height = 37,
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Custom scooter terminal logic
        local Terminal = require("toggleterm.terminal").Terminal
        local scooter_term = nil

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
    end,
}
