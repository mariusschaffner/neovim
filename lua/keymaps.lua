-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- move focus between splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- resize splits
vim.keymap.set("n", "<C-A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-j>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-k>", ":resize +2<CR>", { noremap = true, silent = true })

-- move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")     -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")     -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- buffer related Keymaps
vim.keymap.set("n", "<leader>wn", ":bnext<CR>", { desc = "Next buffer" })         -- Go to next buffer
vim.keymap.set("n", "<leader>wp", ":bprevious<CR>", { desc = "Previous buffer" }) -- Go to previous buffer
vim.keymap.set("n", "<leader>ws", function()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })                            -- Get all listed buffers
  local open_windows = {}                                                         -- Track already opened buffers in windows

  -- Collect buffers currently displayed in windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    open_windows[buf] = true
  end

  -- Iterate over all buffers and open those not currently visible
  for _, buf in ipairs(buffers) do
    if not open_windows[buf.bufnr] then
      vim.cmd("vsplit")               -- Create a vertical split
      vim.cmd("buffer " .. buf.bufnr) -- Load the buffer
    end
  end
end, { desc = "Split all Buffers vertical" })
vim.keymap.set("n", "<leader>wm", function()
  vim.cmd("only") -- Closes all other splits but keeps buffers open
end, { desc = "Maximize current buffer (close splits)" })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- yaml files to ansible files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.yml", "*.yaml"},
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})


-- -- auto hover diagnostics
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false })
--   end,
-- })
-- vim: ts=2 sts=2 sw=2 et
