return {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
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
    end
}
