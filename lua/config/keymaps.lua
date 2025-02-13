-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


vim.keymap.set("n", "<leader>sp", "<cmd>SpotifyPlayPause<CR>", { desc = "Play/Pause Spotify" })
vim.keymap.set("n", "<leader>sn", "<cmd>SpotifyNext<CR>", { desc = "Next Track" })
vim.keymap.set("n", "<leader>sb", "<cmd>SpotifyPrev<CR>", { desc = "Previous Track" })
vim.keymap.set("n", "<leader>ss", "<cmd>SpotifyStatus<CR>", { desc = "Show Current Song" })
vim.keymap.set("n", "<leader>sv", "<cmd>SpotifyVolumeUp<CR>", { desc = "Increase Volume" })
vim.keymap.set("n", "<leader>sd", "<cmd>SpotifyVolumeDown<CR>", { desc = "Decrease Volume" })
