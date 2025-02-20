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

  -- Apply base theme colors
  vim.cmd("highlight Normal guibg=" .. c.base)
  vim.cmd("highlight Comment guifg=" .. c.subtext1 .. " gui=italic")
  vim.cmd("highlight Keyword guifg=" .. c.overlay2)
  vim.cmd("highlight Function guifg=" .. c.surface1)
  vim.cmd("highlight String guifg=" .. c.overlay0)

  -- Global UI component highlights
  vim.cmd("highlight StatusLine guifg=" .. c.crust .. " guibg=" .. c.base)
  vim.cmd("highlight StatusLineNC guifg=" .. c.subtext0 .. " guibg=" .. c.mantle)
  vim.cmd("highlight TabLine guifg=" .. c.subtext1 .. " guibg=" .. c.surface0)
  vim.cmd("highlight TabLineSel guifg=" .. c.overlay2 .. " guibg=" .. c.base)
  vim.cmd("highlight Pmenu guibg=" .. c.surface1 .. " guifg=" .. c.subtext0)
  vim.cmd("highlight PmenuSel guibg=" .. c.overlay1 .. " guifg=" .. c.base)
end

return M
