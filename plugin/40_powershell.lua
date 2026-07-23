vim.pack.add({
    { src = "https://github.com/TheLeoP/powershell.nvim" },
})

require('powershell').setup({
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
})
