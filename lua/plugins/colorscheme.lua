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
  {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_dark')
  end,
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
  },
}
