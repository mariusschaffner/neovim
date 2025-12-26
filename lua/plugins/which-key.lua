return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "[?] Buffer Local Keymaps",
      },
    },
    opts = {
      preset = "helix",
      delay = 0,
      icons = {
        mappings = false,
        keys = vim.g.have_nerd_font and {} or {
          Up = "",
          Down = "",
          Left = "",
          Right = "",
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
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
