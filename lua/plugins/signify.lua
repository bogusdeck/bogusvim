return {
    "mhinz/vim-signify",
    event = "VeryLazy",
    config = function()
      vim.g.signify_vcs_list = { "hg", "git" } -- Ensure Mercurial (`hg`) is enabled
      vim.g.signify_sign_add = "│" -- Symbol for added lines
      vim.g.signify_sign_change = "│" -- Symbol for modified lines
      vim.g.signify_sign_delete = "_" -- Symbol for deleted lines
  
      -- Enable the sign column to make sure symbols appear
      vim.o.signcolumn = "yes"
  
      -- Keymaps to toggle
      vim.keymap.set("n", "<leader>ht", ":SignifyToggle<CR>", { desc = "Toggle Signify (HG Diff)", noremap = true, silent = true })
      vim.keymap.set("n", "]c", ":SignifyNextHunk<CR>", { desc = "Next Change", noremap = true, silent = true })
      vim.keymap.set("n", "[c", ":SignifyPrevHunk<CR>", { desc = "Previous Change", noremap = true, silent = true })
    end,
  }
  