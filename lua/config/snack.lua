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
  disable_netrw = true,
  hijack_netrw = true,
  sync_root_with_cwd = true,

  view = {
      width = 30,
      side = "right",  -- Ensure Snack opens on the right
  },

  renderer = {
      highlight_opened_files = "all",
      icons = {
          show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,  -- Correct setting for showing git icons
          },
          git_placement = "before",
      },
  },

  git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
  },

  filters = {
      custom = { "node_modules", ".git" },
  },
})
