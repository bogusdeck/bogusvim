return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", false },
      {
        "<leader>m",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      -- VS Code-like explorer toggle (<C+S+E>)
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer (VSCode-like)",
        remap = true,
      },
    },
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true,
        layout = {
          layout = {
            position = "left",
          },
        },
      },
    },
  },
}
