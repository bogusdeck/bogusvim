local map = vim.keymap.set

-- Ensure Neo-Tree is installed before mapping
map("n", "<leader>e", function()
  vim.cmd("Neotree toggle")
end, { noremap = true, silent = true, desc = "Toggle NeoTree" })
map("n", "<leader>E", function()
  vim.cmd("Neotree toggle reveal root<CR>")
end, { noremap = true, silent = true, desc = "Toggle Neo-Tree (Root)" })


-- Fix missing 'q' mapping inside Neo-Tree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":Neotree close<CR>", { noremap = true, silent = true })
  end,
})
