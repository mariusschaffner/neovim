-- =========================================================
-- Neovim Keymaps
-- =========================================================

local keymap = vim.keymap.set

-- ---------------------------------------------------------
-- Basic behavior
-- ---------------------------------------------------------
-- Clear search highlights when pressing <Esc> in normal mode
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlights",
})

-- Exit terminal mode more easily
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", {
  desc = "Exit terminal mode",
})

-- ---------------------------------------------------------
-- Navigation discipline
-- ---------------------------------------------------------
-- Disable arrow keys in normal mode to encourage hjkl usage
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- ---------------------------------------------------------
-- Window navigation
-- ---------------------------------------------------------
-- Move focus between splits using Ctrl + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })

-- ---------------------------------------------------------
-- Window resizing
-- ---------------------------------------------------------
-- Resize splits using Ctrl + Alt + hjkl
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

-- ---------------------------------------------------------
-- Moving lines
-- ---------------------------------------------------------
-- Move the current line up or down in normal mode
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", {
  desc = "Move line down",
})
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", {
  desc = "Move line up",
})

-- Move selected lines up or down in visual mode
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", {
  desc = "Move selection down",
})
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", {
  desc = "Move selection up",
})

-- ---------------------------------------------------------
-- Buffer management
-- ---------------------------------------------------------
-- Navigate between buffers
keymap("n", "<leader>wn", "<cmd>bn<CR>", {
  desc = "Next buffer",
})
keymap("n", "<leader>wp", "<cmd>bp<CR>", {
  desc = "Previous buffer",
})

-- Open all listed buffers in vertical splits
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

-- Close all other splits and focus the current buffer
keymap("n", "<leader>wm", "<cmd>only<CR>", {
  desc = "Maximize current buffer",
})

-- ---------------------------------------------------------
-- Autocommands
-- ---------------------------------------------------------
-- Highlight yanked text briefly for visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Treat YAML files as Ansible YAML
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.yml", "*.yaml" },
--   desc = "Set Ansible filetype for YAML files",
--   group = vim.api.nvim_create_augroup("ansible-yaml", { clear = true }),
--   callback = function()
--     vim.bo.filetype = "yaml.ansible"
--   end,
-- })

-- ---------------------------------------------------------
-- Optional: automatic diagnostic hover (disabled)
-- ---------------------------------------------------------
-- Automatically show diagnostics under the cursor when idle.
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--   end,
-- })

-- ---------------------------------------------------------
-- Plugin specific keymaps
-- ---------------------------------------------------------
-- Open Git Diff
vim.keymap.set("n", "<leader>gd", ":CodeDiff<CR>", { desc = "[G]it [D]iff" })

-- vim: ts=2 sts=2 sw=2 et
