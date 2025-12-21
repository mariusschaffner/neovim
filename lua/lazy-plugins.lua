-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  require("plugins.which-key"),
  require("plugins.treesitter"),
  require("plugins.toggleterm"),
  require("plugins.theme"),
  require("plugins.snacks"),
  require("plugins.rest"),
  require("plugins.multicursor"),
  require("plugins.markdown"),
  require("plugins.git"),
  require("plugins.blink-cmp"),
  require("plugins.conform"),
  require("plugins.autopairs"),
  require("plugins.lspconfig"),
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
