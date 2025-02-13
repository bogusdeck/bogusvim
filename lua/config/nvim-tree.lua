require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = true,
    sync_root_with_cwd = true,
  
    update_focused_file = {
      enable = true,
      update_root = false,
    },
  
    git = {
      enable = true,  -- Git integration
    },
  
    view = {
      width = 30,
      side = "left",
      adaptive_size = false,
    },
  
    renderer = {
      indent_markers = {
        enable = true, -- Enable indentation markers
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,  -- Correct way to show git icons
        },
      },
    },
  })
  