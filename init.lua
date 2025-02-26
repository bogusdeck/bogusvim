-- bootstrap lazy.nvim, LazyVim and your plugins
require("themes.custom_theme").setup()
vim.g.mapleader = " "
vim.g.maplocalleader = " " 
require("config.keymaps")
require("config.autocmds")
require("config.lazy")