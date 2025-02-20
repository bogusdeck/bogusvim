return {
    -- tools
    {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "flake8",
            "ts_ls"
          },
        },
    },
    
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "neovim/nvim-lspconfig" },  -- Mason still relies on lspconfig internally
  config = function()
      require("mason-lspconfig").setup({
          ensure_installed = {"ts_ls", "pyright", "lua_ls" }, -- Add the LSP servers you need
          automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
          function(server_name)
              lspconfig[server_name].setup({})
          end,
      })
  end,
}


}
