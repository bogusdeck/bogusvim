return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      -- ✅ Define highlight groups
      vim.api.nvim_set_hl(0, "BadWhitespace", { fg = "#FF5F5F", bg = "NONE", underline = true })
      vim.api.nvim_set_hl(0, "MixedIndent", { fg = "#FF8700", bg = "NONE", underline = true })
  
      -- ✅ Function to toggle whitespace highlighting only for specific filetypes
      local function toggle_whitespace_highlight()
        local ft = vim.bo.filetype
  
        -- ❌ Disable whitespace highlighting in unwanted filetypes
        local ignored_filetypes = {
          "dashboard", "alpha", "TelescopePrompt", "TelescopeResults",
          "lazy", "noice", "help", "gitcommit", "markdown",
        }
  
        -- ✅ Enable highlighting **only** for these filetypes
        local allowed_filetypes = {
          python = true,
          html = true,
          javascript = true,
        }
  
        -- Remove existing matches
        if vim.g.bad_whitespace_match_id then
          pcall(vim.fn.matchdelete, vim.g.bad_whitespace_match_id)
          vim.g.bad_whitespace_match_id = nil
        end
  
        if vim.g.mixed_indent_match_id then
          pcall(vim.fn.matchdelete, vim.g.mixed_indent_match_id)
          vim.g.mixed_indent_match_id = nil
        end
  
        -- ✅ Enable highlighting only for allowed filetypes
        if allowed_filetypes[ft] then
          vim.g.bad_whitespace_match_id = vim.fn.matchadd("BadWhitespace", "\\s\\+$")
          vim.g.mixed_indent_match_id = vim.fn.matchadd("MixedIndent", "^ \\+\\t\\|^\\t\\+ ")
        end
      end
  
      -- ✅ Apply highlighting when entering a buffer (ignoring Telescope, Noice, etc.)
      vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
        callback = toggle_whitespace_highlight,
      })
  
      -- ✅ Auto-refresh highlights on ColorScheme change
      vim.cmd([[
        autocmd ColorScheme * highlight BadWhitespace guifg=#FF5F5F gui=underline
        autocmd ColorScheme * highlight MixedIndent guifg=#FF8700 gui=underline
      ]])
    end,
  }
  