return {
    {
      "folke/tokyonight.nvim",
      opts = {
        style = "night",
        on_colors = function(colors)
          colors.bg        = "#040a0c"  -- base
          colors.mantle    = "#061115"
          colors.crust     = "#78D6C6"
          colors.subtext1  = "#bac2de"
          colors.subtext0  = "#a6adc8"
          colors.overlay2  = "#008170"
          colors.overlay1  = "#04364A"
          colors.overlay0  = "#419197"
          colors.surface2  = "#2D9596"
          colors.surface1  = "#176B87"
          colors.surface0  = "#265073"
        end,
        on_highlights = function(highlights, colors)
          -- General Editor Highlights
          highlights.Normal         = { fg = colors.subtext1, bg = colors.bg }
          highlights.Comment        = { fg = colors.subtext0, italic = true }
          highlights.Conditional    = { fg = colors.overlay2, italic = true }
          highlights.String         = { fg = colors.surface2 }
          highlights.Function       = { fg = colors.overlay0 }
          highlights.Identifier     = { fg = colors.surface1 }
          highlights.Type           = { fg = colors.crust }
          highlights.LineNr         = { fg = colors.subtext1 }
          highlights.CursorLineNr   = { fg = colors.surface0 }
          highlights.Visual         = { bg = colors.overlay1 }
  
          -- LuaLine Overrides
          highlights.StatusLine         = { fg = colors.crust, bg = colors.mantle }
          highlights.StatusLineNC       = { fg = colors.subtext0, bg = colors.bg }
          highlights.StatusLineSeparator = { fg = colors.overlay2, bg = colors.bg }
          highlights.StatusLineTerm     = { fg = colors.overlay0, bg = colors.mantle }
          highlights.StatusLineTermNC   = { fg = colors.subtext1, bg = colors.bg }
  
          -- Tabline Overrides
          highlights.TabLine        = { fg = colors.subtext0, bg = colors.bg }
          highlights.TabLineSel     = { fg = colors.overlay0, bg = colors.crust, bold = true }
          highlights.TabLineFill    = { fg = colors.subtext1, bg = colors.mantle }
  
          -- Pmenu (Autocomplete menu)
          highlights.Pmenu          = { fg = colors.subtext1, bg = colors.mantle }
          highlights.PmenuSel       = { fg = colors.crust, bg = colors.overlay0, bold = true }
          highlights.PmenuThumb     = { fg = colors.overlay1, bg = colors.surface0 }
  
          -- Search Highlights
          highlights.Search         = { fg = colors.crust, bg = colors.surface1 }
          highlights.IncSearch      = { fg = colors.crust, bg = colors.overlay2 }
        end,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
  }
  