-- ~/.config/nvim/lua/config/neo-tree.lua
local custom_colors = {
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
  
  require("neo-tree").setup({
    window = {
      position = "right",  -- Ensure explorer opens on the right
      width = 30,         -- Set width of the explorer window
    },
    filesystem = {
      window = {
        mappings = {
          ["<space> + m"] = "open",  -- Keep your existing keybinding here
          ["<space> + M"] = "toggle",  -- Custom keybinding for Space + M
        },
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
        highlight = custom_colors.surface0,  -- Set background color
      },
      text = {
        highlight = custom_colors.subtext1, -- File text color
      },
      git_status = {
        added = { fg = custom_colors.overlay2 },
        modified = { fg = custom_colors.overlay0 },
        deleted = { fg = custom_colors.crust },
      },
    },
  })
  