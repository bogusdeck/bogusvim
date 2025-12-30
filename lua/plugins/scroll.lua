return {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic", -- Smooth scroll effect
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at end of file
        respect_scrolloff = true, -- Keep `scrolloff` when scrolling
        cursor_scrolls_alone = false, -- Cursor follows window scroll
      })
  
      -- ✅ Fix: Use `duration` instead of `time`
      local neoscroll = require("neoscroll")
  
      local mappings = {
        ["<C-u>"] = function() neoscroll.scroll(-vim.wo.scroll, { move_cursor = true, duration = 100 }) end,
        ["<C-d>"] = function() neoscroll.scroll(vim.wo.scroll, { move_cursor = true, duration = 100 }) end,
        ["<C-b>"] = function() neoscroll.scroll(-vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 200 }) end,
        ["<C-f>"] = function() neoscroll.scroll(vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 200 }) end,
        ["<C-y>"] = function() neoscroll.scroll(-4, { move_cursor = false, duration = 50 }) end,
        ["<C-e>"] = function() neoscroll.scroll(4, { move_cursor = false, duration = 50 }) end,
      }
  
      -- ✅ Apply the fixed key mappings
      for key, func in pairs(mappings) do
        vim.keymap.set("n", key, func, { silent = true, noremap = true })
      end
    end,
  }
  