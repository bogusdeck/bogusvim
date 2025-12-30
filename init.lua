-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("custom.spotify")
vim.cmd("autocmd VimEnter * Dashboard")

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
