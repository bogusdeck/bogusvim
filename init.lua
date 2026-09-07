-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("custom.spotify")
require("custom.ai-toggle").setup()

-- Disable netrw's FileExplorer (opens on directory)
pcall(vim.api.nvim_del_augroup_by_name, "FileExplorer")

-- Enable AI suggestions by default (0 = disabled, 1 = enabled)
vim.g.ai_suggestions_enabled = 0
vim.g.ai_cmp = false  -- Use virtual text (ghost text) instead of cmp source

-- Toggle AI suggestions (Copilot + Codeium)
vim.keymap.set('n', '<leader>ai', '<cmd>AIToggle<CR>', { desc = 'Toggle AI suggestions', silent = true })
if vim.env.NVIM_CODEMAP ~= "1" then
  vim.cmd("autocmd VimEnter * Dashboard")
end

-- Disable auto format on save
vim.g.autoformat = false

-- helper function to confirm quit
local function confirm_quit(cmd)
  local choice = vim.fn.confirm("Bhai Jana Chawe haii?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.api.nvim_echo({{"Fir milte Ladle", "WarningMsg"}}, false, {})
    vim.cmd(cmd)
  else
    vim.api.nvim_echo({{"Ladle tu kithe na Jawee", "WarningMsg"}}, false, {})
  end
end

-- Override common quit commands
vim.api.nvim_create_user_command("Q", function() confirm_quit("q") end, {})
vim.api.nvim_create_user_command("Qa", function() confirm_quit("qa") end, {})
vim.api.nvim_create_user_command("Wq", function() confirm_quit("wq") end, {})
vim.api.nvim_create_user_command("Wqa", function() confirm_quit("wqa") end, {})

-- remap lowercase ones too
vim.cmd([[
  cabbrev q Q
  cabbrev qa Qa
  cabbrev wq Wq
  cabbrev wqa Wqa
]])


-- Move current line or selection up/down using Leader key
-- Press Space + k to move up, Space + j to move down
vim.keymap.set('n', '<leader>k', ':mcao<CR>gv=gv', { silent = true })
vim.keymap.set('n', '<leader>j', ':mca+2<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<leader>k', ':m\'< -2<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<leader>j', ':m\'> +2<CR>gv=gv', { silent = true })
