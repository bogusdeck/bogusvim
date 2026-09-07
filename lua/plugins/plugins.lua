-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false, -- load during startup
  --   priority = 1000, -- load before other plugins
  --   config = function()
  --     -- Configure nightfox if needed
  --     require('nightfox').setup({
  --       -- your configuration comes here
  --     })
  --     -- Set colorscheme after the plugin is loaded
  --     vim.cmd("colorscheme carbonfox")
  --   end,
  -- },
  -- Configure LazyVim colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_default",
      dashboard = false,
    },
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        table.insert(opts.sources, 1, { name = "copilot" })
        table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Projet management with telescope
  {
    "ahmedkhalf/project.nvim",
    opts = { manual_mode = true },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find Word" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Find Symbols" },
      { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects{}<CR>", desc = "Projects" },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "python",
        "html",
        "css",
        "javascript",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown_inline",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
          options = { theme = 'auto'}
      }
    end,
  },

  -- Bufferline for tab management (VS Code-like tabs)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          always_show_bufferline = true,
          enforce_regular_bg = true,
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
          },
          -- VS Code-like behavior: click to switch, drag to reorder
          movable = true,
          right_click_command = "vertical wincmd L", -- Right-click opens in vertical split
          middle_click_command = "bdelete", -- Middle-click closes buffer
        },
        highlights = {
          background = {
            bg = "#1f1f1f",
          },
          tab_selected = {
            bg = "#0e63d2",
            fg = "#ffffff",
            bold = true,
          },
          tab_close = {
            fg = "#f0f0f0",
          },
          close_button = {
            fg = "#f0f0f0",
          },
          buffer_selected = {
            bg = "#1f1f1f",
            fg = "#ffffff",
            bold = true,
          },
          indicator_selected = {
            fg = "#4ec9b0",
            icon = "▊",
          },
        },
      })
    end,
  },

  -- Re-enable trouble since LazyVim depends on it
  {
    "folke/trouble.nvim",
    enabled = true,
    opts = {
      use_diagnostic_signs = true,
    },
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter", enabled = false },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  -- tools installation (via Mason)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pylint", -- linter
        -- Go
        "gopls",
        "gofumpt",
        "goimports",
        "golangci-lint",
        -- Python
        "basedpyright",
        "ruff",
        "black",
        "isort",
        "mypy",
        -- JavaScript/TypeScript/React/Next.js/Node
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "biome",
        -- HTML/CSS (for React/Next.js)
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        -- JSON/YAML
        "json-lsp",
        "yaml-language-server",
      },
    },
  },

  -- LSP config (via lspconfig)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = false, -- 🚫 disable pyright
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        -- Python (using basedpyright + ruff)
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
        -- JavaScript/TypeScript/React/Next.js/Node
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        eslint = {},
        biome = {},
        -- HTML/CSS/Tailwind (for React/Next.js)
        html = {},
        cssls = {},
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "tw`([^`]*)",
                  "tw=\"([^\"]*)",
                  "tw={'([^']*)'}",
                  "className=\"([^\"]*)",
                  "className={'([^']*)'}",
                  "clsx\\(([^)]*)\\)",
                  "cn\\(([^)]*)\\)",
                },
              },
            },
          },
        },
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
        },
        -- JSON/YAML
        jsonls = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },
}
