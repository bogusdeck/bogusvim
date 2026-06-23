-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigate between tabs using Bufferline
local function next_buffer()
  if vim.fn.exists(":BufferLineCycleNext") == 2 then
    vim.cmd.BufferLineCycleNext()
  else
    vim.cmd.bnext()
  end
end

local function prev_buffer()
  if vim.fn.exists(":BufferLineCyclePrev") == 2 then
    vim.cmd.BufferLineCyclePrev()
  else
    vim.cmd.bprevious()
  end
end

vim.keymap.set({ "n", "i" }, "<A-Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set({ "n", "i" }, "<M-Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set("n", "<Esc><Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set({ "n", "i" }, "<A-S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set({ "n", "i" }, "<M-S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })

-- Move buffers left/right
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })

-- Close buffer
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<D-w>", ":bdelete<CR>", { desc = "Close buffer", noremap = true, silent = true })

--  Select All (Like Ctrl+A in VS Code)
vim.keymap.set("n", "<D-a>", "ggVG", { desc = "Select all", noremap = true, silent = true })

--  Copy Current Line Below (Like Shift+Alt+↓ in VS Code)
vim.keymap.set("n", "<S-A-j>", "yyp", { desc = "Copy line below", noremap = true, silent = true })

--  Copy Current Line Above (Like Shift+Alt+↑ in VS Code)
vim.keymap.set("n", "<S-A-k>", "yyP", { desc = "Copy line above", noremap = true, silent = true })

--  Move Line Down (Like Alt+↓ in VS Code)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })

--  Move Line Up (Like Alt+↑ in VS Code)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })

-- Move word forward with Option+Right Arrow
vim.keymap.set("n", "<A-Right>", "w", { desc = "Move word forward", noremap = true, silent = true })
vim.keymap.set("i", "<A-Right>", "<C-o>w", { desc = "Move word forward", noremap = true, silent = true })
vim.keymap.set("v", "<A-Right>", "w", { desc = "Move word forward", noremap = true, silent = true })

-- Move word backward with Option+Left Arrow
vim.keymap.set("n", "<A-Left>", "b", { desc = "Move word backward", noremap = true, silent = true })
vim.keymap.set("i", "<A-Left>", "<C-o>b", { desc = "Move word backward", noremap = true, silent = true })
vim.keymap.set("v", "<A-Left>", "b", { desc = "Move word backward", noremap = true, silent = true })

-- Search in current file with Cmd+F
vim.keymap.set("n", "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file", noremap = true, silent = true })
vim.keymap.set("v", "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file", noremap = true, silent = true })

-- Global search in project with Cmd+Shift+F
vim.keymap.set("n", "<D-F>", "<cmd>Telescope live_grep<CR>", { desc = "Search in project", noremap = true, silent = true })
vim.keymap.set("v", "<D-F>", "<cmd>Telescope live_grep<CR>", { desc = "Search in project", noremap = true, silent = true })

-- Add this somewhere in your keymaps file
vim.keymap.set("n", "<leader>hs", function()
  require("custom.source-control").open_hg_changes()
end, { desc = "Show Mercurial changes" })

vim.keymap.set("n", "<leader>ua", function()
  require("custom.ai-toggle").toggle()
end, { desc = "Toggle AI Suggestions" })

vim.keymap.set("n", "<leader>ll", "<cmd>Leet<CR>", { desc = "Open LeetCode" })
