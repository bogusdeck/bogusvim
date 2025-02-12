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
  
  require("nvim-tree").setup({
    -- Disable netrw, since we're using Snack for file navigation
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
  
    -- Customize the appearance
    renderer = {
      highlight_opened_files = "all",
      icons = {
        webdev_colors = true,  -- Enable colors for web development files
      },
      group_empty = true,  -- Group empty folders together
    },
  
    -- Window configuration for Snack
    view = {
      width = 30,  -- You can adjust the width as per your preference
      side = "right",  -- Make sure it opens on the right
      auto_resize = true,
      mappings = {
        -- Optional keymaps
        ["<space>e"] = "toggle",  -- Use space + e to toggle the Snack explorer
      },
    },
  
    -- Apply custom color scheme
    filters = {
      custom = { "node_modules", ".git" },
    },
  
    -- Set custom highlights
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
      default_color = custom_colors.subtext0,  -- Default color for git status
    },
  
    -- Highlight the file explorer with custom colors
    renderer = {
      icons = {
        git_placement = "before",
        git = {
          unstaged = custom_colors.overlay1,
          staged = custom_colors.surface2,
          untracked = custom_colors.overlay2,
        },
      },
    },
  })
  