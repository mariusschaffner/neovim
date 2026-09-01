local keymap = vim.keymap.set
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlights",
})
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
keymap("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
keymap("n", "<C-A-h>", "<cmd>vertical resize -2<CR>", {
  desc = "Resize split left",
  silent = true,
})
keymap("n", "<C-A-l>", "<cmd>vertical resize +2<CR>", {
  desc = "Resize split right",
  silent = true,
})
keymap("n", "<C-A-j>", "<cmd>resize -2<CR>", {
  desc = "Resize split down",
  silent = true,
})
keymap("n", "<C-A-k>", "<cmd>resize +2<CR>", {
  desc = "Resize split up",
  silent = true,
})
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", {
  desc = "Move line down",
})
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", {
  desc = "Move line up",
})
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", {
  desc = "Move selection down",
})
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", {
  desc = "Move selection up",
})
keymap("n", "<leader>wn", "<cmd>bn<CR>", {
  desc = "Next buffer",
})
keymap("n", "<leader>wp", "<cmd>bp<CR>", {
  desc = "Previous buffer",
})
keymap("n", "<leader>ws", function()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local open_buffers = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    open_buffers[vim.api.nvim_win_get_buf(win)] = true
  end
  for _, buf in ipairs(buffers) do
    if not open_buffers[buf.bufnr] then
      vim.cmd("vsplit")
      vim.cmd("buffer " .. buf.bufnr)
    end
  end
end, {
  desc = "Split all buffers vertically",
})
keymap("n", "<leader>wm", "<cmd>only<CR>", {
  desc = "Maximize current buffer",
})
keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })
keymap("n", "<leader>gd", ":CodeDiff<CR>", { desc = "[G]it [D]iff" })
keymap("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "[G]it [b]lame" })
keymap("n", "<leader>gi", ":Atlas issues<CR>", { desc = "[G]itlab [i]ssues" })
keymap("n", "<leader>gm", ":Atlas pulls<CR>", { desc = "[G]itlab [m]erge_requests" })
