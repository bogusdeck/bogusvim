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
    },
  },
}
