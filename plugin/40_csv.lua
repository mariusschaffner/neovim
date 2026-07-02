vim.pack.add({
  { src = "https://github.com/hat0uma/csvview.nvim" },
})

require("csvview").setup({
  view = {
    display_mode = "border",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.cmd("CsvViewEnable")
  end,
})
