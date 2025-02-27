return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false, -- Keep background opaque
        },
        groups = {
          all = {
            Comment = { fg = "#7AA2F7", style = "italic" }, -- Normal comments
            ["@comment"] = { fg = "#7AA2F7", style = "italic" }, -- Treesitter comments
            ["@string"] = { fg = "#A6E3A1", style = "italic" }, -- Normal strings (includes docstrings)
            ["@string.documentation"] = { fg = "#A6E3A1", style = "italic" }, -- (May not work for Python)
            ["@text"] = { fg = "#A6E3A1", style = "italic" }, -- General text (extra safety)
          },
        },
      })

      -- Apply the colorscheme
      vim.cmd("colorscheme carbonfox")
    end,
  },
}
