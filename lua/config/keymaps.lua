-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigate between tabs using Bufferline
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Tab" })

-- Move buffers left/right
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })

-- Close buffer
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })

--  Select All (Like Ctrl+A in VS Code)
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all", noremap = true, silent = true })

--  Copy Current Line Below (Like Shift+Alt+↓ in VS Code)
vim.keymap.set("n", "<S-A-j>", "yyp", { desc = "Copy line below", noremap = true, silent = true })

--  Copy Current Line Above (Like Shift+Alt+↑ in VS Code)
vim.keymap.set("n", "<S-A-k>", "yyP", { desc = "Copy line above", noremap = true, silent = true })

--  Move Line Down (Like Alt+↓ in VS Code)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })

--  Move Line Up (Like Alt+↑ in VS Code)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })

-- Add this somewhere in your keymaps file
vim.keymap.set("n", "<leader>hs", function()
  require("custom.source-control").open_hg_changes()
end, { desc = "Show Mercurial changes" })
