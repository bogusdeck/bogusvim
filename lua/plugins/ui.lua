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

          -- Keymaps for opening Neo-Tree
          vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle<CR>", { desc = "Toggle Neo-Tree (CWD)" })
          vim.keymap.set("n", "<leader>E", ":Neotree reveal<CR>", { desc = "Reveal Current File in Neo-Tree" })
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


-- lazy.nvim
{
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  }
}
