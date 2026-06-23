vim.opt_local.conceallevel = 2

vim.keymap.set("n", "<leader>nt", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {
  buffer = true,
  desc = "Neorg Todo Cycle",
})

vim.keymap.set("n", "<leader>nT", "<Plug>(neorg.qol.todo-items.todo.task-cycle-reverse)", {
  buffer = true,
  desc = "Neorg Todo Cycle Reverse",
})

vim.keymap.set("n", "<leader>nd", "<Plug>(neorg.qol.todo-items.todo.task-done)", {
  buffer = true,
  desc = "Neorg Todo Done",
})

vim.keymap.set("n", "<leader>nu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", {
  buffer = true,
  desc = "Neorg Todo Undone",
})
