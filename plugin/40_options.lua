vim.opt.laststatus = 1
vim.opt.cmdheight = 0
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪  "
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 15
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.colorcolumn = "90"
vim.opt.fillchars = {
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
}
vim.o.winborder = 'rounded'
vim.opt.confirm = true
vim.opt.diffopt:append("vertical")
vim.opt.diffopt:append("linematch:60")
