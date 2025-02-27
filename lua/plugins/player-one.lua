return {
    "jackplus-xyz/player-one.nvim",
    cmd = { "PlayerOne" }, -- Load the plugin when using the command
    config = function()
      require("player-one").setup({
        -- Default configuration
        fullscreen = true, -- Run games in fullscreen mode
        animations = true, -- Enable animations
        sound = true, -- Enable sound effects
      })
  
      -- Keymap to open PlayerOne
      vim.keymap.set("n", "<leader>po", ":PlayerOne<CR>", { desc = "Open PlayerOne", noremap = true, silent = true })
    end,
  }
  