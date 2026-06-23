local M = {}

local function notify(message)
  vim.notify(message, vim.log.levels.INFO, { title = "AI Toggle" })
end

local function lazy_load(plugin)
  local ok, lazy = pcall(require, "lazy")
  if ok then
    lazy.load({ plugins = { plugin } })
  end
end

local function codeium_available()
  return pcall(require, "codeium")
end

local function set_copilot(enabled)
  vim.g.copilot_enabled = enabled and 1 or 0
  if vim.fn.exists(":Copilot") == 2 then
    vim.cmd(enabled and "Copilot enable" or "Copilot disable")
  end
end

local function set_codeium(enabled)
  lazy_load("codeium.nvim")
  local ok, codeium = pcall(require, "codeium")
  if ok then
    if enabled then
      codeium.enable()
    else
      codeium.disable()
    end
    return
  end

  if vim.fn.exists(":Codeium") == 2 then
    vim.cmd("Codeium Toggle")
    if enabled ~= (vim.g.ai_suggestions_enabled == 1) and codeium_available() then
      local codeium2 = require("codeium")
      if enabled then
        codeium2.enable()
      else
        codeium2.disable()
      end
    end
  end
end

function M.set(enabled)
  vim.g.ai_suggestions_enabled = enabled and 1 or 0
  set_copilot(enabled)
  set_codeium(enabled)
  notify(enabled and "AI suggestions enabled" or "AI suggestions disabled")
end

function M.toggle()
  M.set(vim.g.ai_suggestions_enabled ~= 1)
end

function M.setup()
  vim.g.ai_suggestions_enabled = vim.g.ai_suggestions_enabled == 0 and 0 or 1
  vim.api.nvim_create_user_command("AIToggle", function()
    M.toggle()
  end, { desc = "Toggle AI code suggestions" })

  vim.api.nvim_create_user_command("AIEnable", function()
    M.set(true)
  end, { desc = "Enable AI code suggestions" })

  vim.api.nvim_create_user_command("AIDisable", function()
    M.set(false)
  end, { desc = "Disable AI code suggestions" })
end

return M
