-- =========================================================
-- Neovim Options
-- =========================================================

-- ---------------------------------------------------------
-- Line numbers
-- ---------------------------------------------------------
-- Show absolute and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- ---------------------------------------------------------
-- Status & command line UI
-- ---------------------------------------------------------
-- Do not show mode (e.g. -- INSERT --)
vim.opt.showmode = false

-- Use a global statusline instead of one per window
vim.opt.laststatus = 3

-- Hide the command line
vim.opt.cmdheight = 0


-- ---------------------------------------------------------
-- Clipboard
-- ---------------------------------------------------------
-- Sync Neovim clipboard with the system clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- ---------------------------------------------------------
-- Line wrapping & indentation
-- ---------------------------------------------------------
-- Enable line wrapping
vim.opt.wrap = true

-- Wrap lines at word boundaries instead of breaking words
vim.opt.linebreak = true

-- Indent wrapped lines to match the indentation of the original line
vim.opt.breakindent = true

-- Character shown at the start of wrapped lines
vim.opt.showbreak = "↪ "

-- ---------------------------------------------------------
-- Undo & backup behavior
-- ---------------------------------------------------------
-- Persist undo history across sessions
vim.opt.undofile = true

-- Disable swap/backup files (modern setups rely on undo + git)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- ---------------------------------------------------------
-- Searching
-- ---------------------------------------------------------
-- Case-insensitive search by default...
vim.opt.ignorecase = true

-- ...but switch to case-sensitive if search contains capitals
vim.opt.smartcase = true

-- ---------------------------------------------------------
-- Window & split behavior
-- ---------------------------------------------------------
-- Always show the sign column
vim.opt.signcolumn = "yes"

-- Open vertical splits to the right
vim.opt.splitright = true

-- Open horizontal splits below
vim.opt.splitbelow = true

-- ---------------------------------------------------------
-- Performance & responsiveness
-- ---------------------------------------------------------
-- Faster completion, CursorHold, and diagnostics updates
vim.opt.updatetime = 250

-- Shorter delay for mapped sequences
vim.opt.timeoutlen = 300

-- Do not redraw while executing macros
vim.opt.lazyredraw = true

-- ---------------------------------------------------------
-- Whitespace visualization
-- ---------------------------------------------------------
-- Show invisible characters
vim.opt.list = true

-- Define which characters to display
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- ---------------------------------------------------------
-- Substitution preview
-- ---------------------------------------------------------
-- Show live preview of :substitute commands in a split window
vim.opt.inccommand = "split"

-- ---------------------------------------------------------
-- Cursor & scrolling
-- ---------------------------------------------------------
-- Highlight the current line
vim.opt.cursorline = true

-- Keep at least 10 lines visible above and below the cursor
vim.opt.scrolloff = 10

-- ---------------------------------------------------------
-- Completion behavior
-- ---------------------------------------------------------
-- Better completion menu behavior (required for nvim-cmp)
vim.opt.completeopt = "menu,menuone,noselect"

-- Limit completion popup height
vim.opt.pumheight = 15

-- ---------------------------------------------------------
-- Indentation & tabs
-- ---------------------------------------------------------
-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Number of spaces used for indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Use basic automatic indentation
vim.opt.autoindent = true

-- ---------------------------------------------------------
-- Visual helpers
-- ---------------------------------------------------------
-- Highlight a column to indicate preferred maximum line length
vim.opt.colorcolumn = "90"

-- Use nicer characters for window separators
vim.opt.fillchars = {
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
}

-- border for all floats
vim.o.winborder = 'rounded'

-- ---------------------------------------------------------
-- Safety & confirmations
-- ---------------------------------------------------------
-- Ask for confirmation instead of erroring on unsaved changes
vim.opt.confirm = true
-- ---------------------------------------------------------
-- Diff behavior
-- ---------------------------------------------------------
-- Use vertical diffs and smarter line matching
vim.opt.diffopt:append("vertical")
vim.opt.diffopt:append("linematch:60")

-- vim: ts=2 sts=2 sw=2 et
