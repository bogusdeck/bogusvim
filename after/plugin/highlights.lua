-- VS Code-like highlights
-- Make indents less visible like VS Code
vim.api.nvim_set_hl(0, "IblChar", { fg = "#363636", link = nil })
vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#5a5a5a", link = nil })

-- Cursor like VS Code
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor"

-- Make the statusline look cleaner (LazyVim default is already VS Code-like)
