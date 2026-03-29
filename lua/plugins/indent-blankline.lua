return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      enabled = true,
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },
    }
  end,
  config = function(_, opts)
    require("ibl").setup(opts)
    
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        vim.b.indent_blankline_enabled = false
        require("ibl").setup_buffer(0, { enabled = false })
      end,
    })
  end,
}
