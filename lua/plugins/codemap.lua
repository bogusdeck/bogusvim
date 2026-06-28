return {
  {
    dir = vim.fn.expand("~/Projects/codemap.nvim"),
    name = "codemap.nvim",
    lazy = false,
    config = function()
      local codemap = require("codemap")
      codemap.setup({
        workspace = "~/Projects/leet",
      })

      codemap.open_shared_layout = codemap.open
    end,
  },
}
