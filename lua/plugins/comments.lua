return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    local comment = require("Comment")

    comment.setup()

    -- ✅ Fix: Use `require('Comment.api')` for correct mappings
    local api = require("Comment.api")
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = "Toggle Comment" }

    -- Normal Mode: Toggle comment for the current line
    map("n", "<leader>/", api.toggle.linewise.current, opts)

    -- Visual Mode: Toggle comment for selected lines
    map("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
  end,
}
