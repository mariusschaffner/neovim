-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set proper c compiler (requires gcc.exe from mingw32)
vim.env.CC = "gcc"

require('vim._core.ui2').enable({})
