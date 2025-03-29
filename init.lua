-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("custom.spotify")
vim.cmd("autocmd VimEnter * Dashboard")
