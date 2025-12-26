return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.diagnostic.config({
        -- virtual_lines = true,
        virtual_text = true,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        lua_ls = {},
        yamlls = {},
        terraformls = {},
      }
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              settings = servers[server_name].settings,
            })
          end,
        },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
