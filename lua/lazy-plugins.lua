-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  require("plugins.theme"),
  require("plugins.treesitter"),
  require("plugins.lspconfig"),
  require("plugins.blink-cmp"),
  require("plugins.which-key"),
  require("plugins.toggleterm"),
  require("plugins.snacks"),
  -- require("plugins.rest"),
  require("plugins.multicursor"),
  require("plugins.markdown"),
  require("plugins.indent_line"),
  -- require("plugins.debug"),
  require("plugins.conform"),
  require("plugins.autopairs"),
  require("plugins.git"),
  -- require("plugins.lualine")
}, {
  ui = {
    backdrop = false,
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
