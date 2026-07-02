vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range("1.*") },
})

require("fidget").setup({})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config('*', {
    capabilities = capabilities,
})

local servers = {
    lua_ls = {},
    yamlls = {},
    terraformls = {},
    basedpyright = {},
    powershell_es = {},
}

for name, cfg in pairs(servers) do
    if next(cfg) ~= nil then
        vim.lsp.config(name, cfg)
    end
end

require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
})
