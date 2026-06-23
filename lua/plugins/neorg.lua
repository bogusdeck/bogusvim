return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "norg") then
        table.insert(opts.ensure_installed, "norg")
      end
    end,
  },
}
