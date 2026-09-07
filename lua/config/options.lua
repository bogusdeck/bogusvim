-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.cmd.colorscheme("carbonfox")
vim.opt.tabstop = 4        -- A tab character displays as 4 spaces
vim.opt.shiftwidth = 4     -- Indentation level is 4 spaces
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.softtabstop = 4    -- Makes backspacing behave as expected

-- VS Code-like UI options
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.cursorline = true      -- Highlight current line
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.colorcolumn = "0"      -- No color column
vim.opt.wrap = false           -- No line wrapping
vim.opt.scrolloff = 8          -- Lines of context around cursor
vim.opt.sidescrolloff = 8      -- Vertical context

-- Font configuration (for GUI Neovim frontends like Neovide, Goneovim, etc.)
vim.opt.guifont = "Hurmit Nerd Font:h13"
