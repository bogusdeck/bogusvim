return {
  -- GitHub Copilot Plugin
  {
      "github/copilot.vim",
      event = "InsertEnter",  -- Load Copilot when entering insert mode
  },

  -- Lualine Plugin
  {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
          require("config.lualine")
      end,
  },

  -- Neo-tree Plugin
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.neo-tree")
    end,
  },

  -- nvim-tree (for snack)
  {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
          require("config.snack")  -- Ensure Snack config is loaded
      end,
  },

  -- Spotify integration
  {
    "KadoBOT/nvim-spotify",
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Requires telescope
    build = "make",
    config = function()
        require("nvim-spotify").setup({
            status = {
                format = "%s - %t 🎵", -- Customize how the status appears
            },
        })
    end,
  },
}
