return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
init = function()
      local parser_path = vim.fn.expand(
        "~/.local/share/nvim/lazy-rocks/tree-sitter-norg/lib/lua/5.1/parser/norg.so"
      )
      local meta_parser_path = vim.fn.expand(
        "~/.local/share/nvim/lazy-rocks/tree-sitter-norg-meta/lib/lua/5.1/parser/norg_meta.so"
      )

      if vim.fn.filereadable(parser_path) == 1 then
        vim.treesitter.language.add("norg", { path = parser_path })
      end
      if vim.fn.filereadable(meta_parser_path) == 1 then
        vim.treesitter.language.add("norg_meta", { path = meta_parser_path })
      end
    end,
    keys = {
      { "<leader>nn", "<Plug>(neorg.dirman.new-note)", desc = "Neorg New Note" },
      { "<leader>ni", "<cmd>Neorg index<CR>", desc = "Neorg Index" },
      { "<leader>nj", "<cmd>Neorg journal today<CR>", desc = "Neorg Journal Today" },
      { "<leader>nr", "<cmd>Neorg return<CR>", desc = "Neorg Return" },
      { "<leader>nw", "<cmd>Neorg workspace notes<CR>", desc = "Neorg Notes Workspace" },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = vim.fn.expand("~/notes/neorg"),
            },
            default_workspace = "notes",
          },
        },
      },
    },
  },
}
