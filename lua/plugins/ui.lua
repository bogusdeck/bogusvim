return {
    {
      dir = "~/.config/nvim/lua/themes", -- Load your custom theme
      name = "custom_theme",
      lazy = false,
      priority = 1000,
      config = function()
        require("themes.custom_theme").setup()
      end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "BufReadPre",
        config = function()
          require("neoscroll").setup({
            easing_function = "quadratic",
            hide_cursor = false,
            stop_eof = true,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            pre_hook = nil,
            post_hook = nil,
          })
        end,
      },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        },
        config = function()
          local colors = require("themes.custom_theme").colors

          require("neo-tree").setup({
            window = {
              width = 30,
              mappings = {
                ["<CR>"] = "open",
                ["l"] = "open",
                ["h"] = "close_node",
                ["q"] = "close_window",
              },
            },
            filesystem = {
              filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
              },
            },
            renderer = {
              highlight_git = true,
              highlight_opened_files = "all",
              highlight_modified = "all",
            },
          })

          -- Apply custom colors using nvim_set_hl
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.surface0 })
          vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = colors.overlay2, bold = true })
          vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.surface1 })
          vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.subtext1 })

        end,
    },
      -- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	},
    -- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		opts = {
			options = {
				-- globalstatus = false,
				-- theme = "tokyonight",
				theme="ayu_dark"
				-- theme = "catppuccin-mocha",
				-- theme="solarized_dark"
			},
		},
	},
  {
  "utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
		  "SmiteshP/nvim-navic",
		  "nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
		  -- configurations go here
		  theme = 'tokyonight-night'
		},
	},
    -- animations
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	event = "VeryLazy",
	-- 	opts = function(_, opts)
	-- 		opts.scroll = {
	-- 			enable = false,
	-- 		}
	-- 	end,
	-- },
    --   {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("noice").setup({
    --             cmdline = {
    --                 enabled = true, -- Enable the command-line UI
    --                 view = "cmdline_popup", -- Use a popup for commands
    --                 format = {
    --                     cmdline = { icon = "" }, -- Change the command icon
    --                     search_down = { icon = "🔍⌄" },
    --                     search_up = { icon = "🔍⌃" },
    --                     filter = { icon = "$" },
    --                     lua = { icon = "" },
    --                     help = { icon = "?" },
    --                 },
    --             },
    --             messages = {
    --                 enabled = true, -- Enables the message UI
    --                 view = "mini", -- Use mini popups instead of default
    --             },
    --             popupmenu = {
    --                 enabled = true, -- Enable popup menu
    --                 backend = "nui",
    --             },
    --             lsp = {
    --                 progress = { enabled = true }, -- Show LSP progress
    --                 hover = { enabled = true },
    --                 signature = { enabled = true },
    --             },
    --             notify = {
    --                 enabled = true, -- Use Noice for notifications
    --                 view = "notify",
    --             },
    --             views = {
    --                 cmdline_popup = {
    --                     position = {
    --                         row = 10,
    --                         col = "50%",
    --                     },
    --                     size = {
    --                         width = 60,
    --                         height = "auto",
    --                     },
    --                     border = {
    --                         style = "rounded",
    --                         padding = { 0, 1 },
    --                     },
    --                     win_options = {
    --                         winblend = 10,
    --                         winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --                     },
    --                 },
    --             },
    --             routes = {
    --                 {
    --                     filter = { event = "msg_showmode" },
    --                     view = "mini",
    --                 },
    --             },
    --             presets = {
    --                 bottom_search = false, -- Disable bottom search UI
    --                 command_palette = true, -- Use Noice for command input
    --                 long_message_to_split = true, -- Split long messages in a separate window
    --                 inc_rename = false, -- If you use `inc-rename.nvim`, disable this
    --                 lsp_doc_border = true, -- Add border to LSP documentation
    --             },
    --         })
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify", -- Needed for pop-up notifications
    --     },
    -- },    
    {
      "echasnovski/mini.notify",
      version = false,
      config = function()
          require("mini.notify").setup({
              content_format = function(notif)
                  return notif.msg
              end,
              duration = 3000,
              background_colour = "#061115",
          })
      end,
  },
  {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
          require("which-key").setup()
      end,
  },
  
}
