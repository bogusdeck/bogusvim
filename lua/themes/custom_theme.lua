local M = {}

M.colors = {
  base = "#040a0c",
  mantle = "#061115",
  crust = "#78D6C6",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#008170",
  overlay1 = "#04364A",
  overlay0 = "#419197",
  surface2 = "#2D9596",
  surface1 = "#176B87",
  surface0 = "#265073",
}

M.setup = function()
  local c = M.colors

  -- Apply base theme colors with safer string formatting
  vim.cmd(string.format("highlight Normal guibg=%s", c.base))
  vim.cmd(string.format("highlight NormalFloat guibg=%s guifg=%s", c.mantle, c.subtext1))
  vim.cmd(string.format("highlight FloatBorder guibg=%s guifg=%s", c.mantle, c.overlay2))

  -- Explicitly override Pmenu to avoid pink background
  vim.cmd(string.format("highlight Pmenu guibg=%s guifg=%s", c.mantle, c.subtext1))
  vim.cmd(string.format("highlight PmenuSel guibg=%s guifg=%s", c.surface2, c.base))
  vim.cmd(string.format("highlight PmenuBorder guibg=%s guifg=%s", c.mantle, c.overlay2))

  -- Noice.nvim Fix
  vim.cmd(string.format("highlight NoiceCmdlinePopup guibg=%s guifg=%s", c.mantle, c.subtext1))
  vim.cmd(string.format("highlight NoiceCmdlinePopupBorder guibg=%s guifg=%s", c.mantle, c.overlay2))
  vim.cmd(string.format("highlight NoicePopup guibg=%s guifg=%s", c.mantle, c.subtext1))
  vim.cmd(string.format("highlight NoicePopupBorder guibg=%s guifg=%s", c.mantle, c.overlay2))
  vim.cmd(string.format("highlight NoiceConfirm guibg=%s guifg=%s", c.surface2, c.subtext0))

  -- WhichKey Fix
  vim.cmd(string.format("highlight WhichKey guibg=%s guifg=%s", c.mantle, c.subtext1))
  vim.cmd(string.format("highlight WhichKeyBorder guibg=%s guifg=%s", c.mantle, c.overlay2))
  vim.cmd(string.format("highlight WhichKeyFloat guibg=%s guifg=%s", c.mantle, c.overlay2))
end

return M
