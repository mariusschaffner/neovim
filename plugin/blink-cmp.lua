vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  keymap = {
    ["<C-Space>"] = { "show", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    menu = {
      border = "rounded",
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
        components = {
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx) return ctx.label end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
      window = {
        border = "rounded",
      },
    },
  },
  sources = {
    default = { "lsp", "path", "buffer" },
  },
  fuzzy = { implementation = "lua" },
  signature = { enabled = false },
})
