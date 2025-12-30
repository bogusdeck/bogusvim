return {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" }, -- Auto-load when leaving insert mode or changing text
    config = function()
      require("auto-save").setup({
        enabled = false, -- Start disabled by default
        execution_message = {
          message = function() return "💾 Yo kr di save" end, -- Message when saving
          dim = 0.18, -- Fade effect
          cleaning_interval = 1250,
        },
        debounce_delay = 135, -- Delay before auto-save
      })
  
      -- Toggle AutoSave with <leader>as
      vim.g.auto_save_enabled = false
      function ToggleAutoSave()
        vim.g.auto_save_enabled = not vim.g.auto_save_enabled
        if vim.g.auto_save_enabled then
          require("auto-save").enable()
          print("Mitr ah gi mahari yaad")
        else
          require("auto-save").disable()
          print("Mitr na kru save ab")
        end
      end
  
      -- Keymap to toggle auto-save
      vim.keymap.set("n", "<leader>as", ":lua ToggleAutoSave()<CR>", { desc = "Toggle Auto-Save", noremap = true, silent = true })
    end,
  }
  
