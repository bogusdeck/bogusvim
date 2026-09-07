
return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_enabled = 0
  end,
}
