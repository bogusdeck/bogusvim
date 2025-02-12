return {
    -- GitHub Copilot Plugin
    {
        "github/copilot.vim",
        event = "InsertEnter",  -- Load Copilot when entering insert mode
    },

    -- Lualine Plugin
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },  -- Required for file icons
        config = function()
            -- Ensure the lualine configuration is loaded properly
            require("config.lualine")
        end,
    },

      -- Neo-tree Plugin
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",  -- Ensure you're using the correct branch
      requires = {
        "nvim-lua/plenary.nvim",  -- Required for Neo-tree
        "kyazdani42/nvim-web-devicons",  -- Optional for file icons
      },
      config = function()
        require("config.neo-tree")  -- Load your custom Neo-tree config
      end,
    },

    -- nvim-tree (for snack)
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
          require("config.snack")  -- Load your Snack config after installing nvim-tree
        end,
    },
}
