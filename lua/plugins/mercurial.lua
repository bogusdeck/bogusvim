return { 
  {
  "tpope/vim-fugitive", -- Required for better integration
  event = "VeryLazy",
  config = function()
    local hg_blame_buf = nil
    local hg_blame_win = nil

    local function close_hg_blame()
      if hg_blame_win and vim.api.nvim_win_is_valid(hg_blame_win) then
        vim.api.nvim_win_close(hg_blame_win, true)
      end
      if hg_blame_buf and vim.api.nvim_buf_is_valid(hg_blame_buf) then
        vim.api.nvim_buf_delete(hg_blame_buf, { force = true })
      end
      hg_blame_buf = nil
      hg_blame_win = nil
    end

    local function toggle_hg_blame()
      if hg_blame_win and vim.api.nvim_win_is_valid(hg_blame_win) then
        close_hg_blame()
        return
      end

      local file = vim.fn.expand("%")
      if file == "" then
        print("No file detected for Mercurial blame.")
        return
      end

      local current_line = vim.api.nvim_win_get_cursor(0)[1] -- Get current cursor line

      -- Create a new buffer for `hg blame`
      hg_blame_buf = vim.api.nvim_create_buf(false, true)

      -- Create a full-screen split
      vim.cmd("tabnew")
      hg_blame_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(hg_blame_win, hg_blame_buf)

      -- Run `hg blame` with commit hash, author, and date
      local cmd = { "hg", "blame", "-c", "-u", "-d", file } -- `-c` for commit hash, `-u` for author, `-d` for date
      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(hg_blame_buf, 0, -1, false, data)

            -- Move cursor to the same line as in the original file
            local blame_line = math.min(current_line, #data) -- Avoid out-of-range errors
            vim.api.nvim_win_set_cursor(hg_blame_win, { blame_line, 0 })
          end
        end,
      })

      -- Close full-screen blame with `q`
      vim.api.nvim_buf_set_keymap(hg_blame_buf, "n", "q", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
    end

    -- Define a command to toggle Mercurial blame
    vim.api.nvim_create_user_command("HgBlame", toggle_hg_blame, { desc = "Toggle Mercurial Blame (Full Screen)" })

    -- Keymap: `<leader>hb` to toggle Mercurial blame
    vim.keymap.set("n", "<leader>hb", ":HgBlame<CR>", { desc = "Toggle HG Blame (Full Screen)", noremap = true, silent = true })
  end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" }, -- Green for added lines
          change = { text = "│" }, -- Yellow for modified lines
          delete = { text = "_" }, -- Red for deleted lines
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        signcolumn = true, -- Enable sign column
        current_line_blame = false,
        watch_gitdir = { interval = 1000 },
      })
  
      -- ✅ Define colors for changed line numbers
      vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#A6E3A1", bold = true })
      vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#F9E2AF", bold = true })
      vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#F38BA8", bold = true })
      vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" }) -- Fixes the error
    end,
  }, 
}
 