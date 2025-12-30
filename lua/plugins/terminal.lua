return {
    "akinsho/toggleterm.nvim",
    version = "*", -- Always use the latest version
    event = "VeryLazy", -- Lazy-load on first use
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]], -- Toggle terminal with Ctrl + \
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float", -- Other options: "horizontal", "vertical", "tab"
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
        },
      })
  
      -- ✅ Keymaps for Opening Different Terminal Modes
      local Terminal = require("toggleterm.terminal").Terminal
  
      -- Floating terminal
      local float_term = Terminal:new({ direction = "float", hidden = true })
      vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "Toggle Floating Terminal" })
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:q<CR>]], { desc = "Close Floating Terminal", silent = true })

  
      -- Horizontal terminal
      local horiz_term = Terminal:new({ direction = "horizontal", hidden = true })
      vim.keymap.set("n", "<leader>th", function() horiz_term:toggle() end, { desc = "Toggle Horizontal Terminal" })
  
      -- LazyGit (Opens LazyGit inside a terminal)
      local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
      vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle LazyGit" })
    end,
  }
  