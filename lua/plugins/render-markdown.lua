return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },
    opts = {
      preset = "lazy",
      file_types = { "markdown", "markdown.mdx" },
      render_modes = { "n" },
      change_events = { "InsertEnter", "InsertLeave" },
      anti_conceal = {
        enabled = false,
      },
      code = {
        disable_background = { "diff", "go", "python" },
      },
      win_options = {
        conceallevel = {
          default = 0,
          rendered = 3,
        },
        concealcursor = {
          default = "",
          rendered = "",
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      local group = vim.api.nvim_create_augroup("RenderMarkdownForceEnable", { clear = true })

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
        group = group,
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft ~= "markdown" and ft ~= "markdown.mdx" then
            return
          end

          vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
              return
            end

            local ok, render_markdown = pcall(require, "render-markdown")
            if not ok then
              return
            end

            render_markdown.buf_enable()
            render_markdown.render({
              buf = args.buf,
              event = args.event,
            })
          end, 100)
        end,
      })
    end,
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
      { "<leader>uM", "<cmd>RenderMarkdown buf_toggle<CR>", desc = "Toggle Markdown Render Buffer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      for _, parser in ipairs({
        "markdown",
        "markdown_inline",
        "html",
        "yaml",
        "latex",
        "go",
        "python",
        "javascript",
        "typescript",
        "java",
        "c",
        "cpp",
      }) do
        if not vim.tbl_contains(opts.ensure_installed, parser) then
          table.insert(opts.ensure_installed, parser)
        end
      end
    end,
  },
}
