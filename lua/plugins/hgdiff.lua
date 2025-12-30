return {
  "sindrets/diffview.nvim",
  config = function()
    local diffview = require("diffview")

    diffview.setup({
      enhanced_diff_hl = true, -- Use better highlighting
      view = {
        merge_tool = {
          layout = "diff3_mixed", -- Layout for merging
          disable_diagnostics = true,
        },
      },
      file_panel = {
        listing_style = "tree", -- Display files in a tree view
        win_config = { position = "left", width = 35 },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          vim.opt_local.wrap = false
          vim.opt_local.list = false
        end,
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>ho", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
    vim.keymap.set("n", "<leader>hc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
    vim.keymap.set("n", "<leader>hh", "<cmd>DiffviewFileHistory<CR>", { desc = "File History" })
  end,
}
