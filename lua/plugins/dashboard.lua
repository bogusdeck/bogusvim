return {
    "nvimdev/dashboard-nvim",
    enabled = true,
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      -- ASCII art logo - each line is exactly 58 chars wide
      local logo_lines = {
        "██████╗  ██████╗  ██████╗ ██╗   ██╗███████╗██████╗ ███████╗ ██████╗██╗  ██╗",
        "██╔══██╗██╔═══██╗██╔════╝ ██║   ██║██╔════╝██╔══██╗██╔════╝██╔════╝██║ ██╔╝",
        "██████╔╝██║   ██║██║  ███╗██║   ██║███████╗██║  ██║█████╗  ██║     █████╔╝",
        "██╔══██╗██║   ██║██║   ██║██║   ██║╚════██║██║  ██║██╔══╝  ██║     ██╔═██╗",
        "██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████║██████╔╝███████╗╚██████╗██║  ██╗",
        "╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝",
      }

      -- Dynamically center logo based on terminal width and height
      local term_width = vim.o.columns
      local term_height = vim.o.lines
      local logo_width = 58 -- width of each logo line
      local logo_height = #logo_lines
      
      -- Calculate horizontal padding (center the logo)
      local h_padding = math.max(2, math.floor((term_width - logo_width) / 2))
      
      -- Calculate vertical padding (place logo roughly 1/3 from top)
      local top_padding = math.max(3, math.floor((term_height - logo_height) / 3))
      
      -- Build the final logo string with dynamic padding
      local logo = string.rep("\n", top_padding)
      for _, line in ipairs(logo_lines) do
        logo = logo .. string.rep(" ", h_padding) .. line .. "\n"
      end
      logo = logo .. "\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          week_header = {
            enable = false,
          },
          disable_move = true,
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
            { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
            { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
            { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
            { action = 'NeovimProjectDiscover',                          desc = " Projects",        icon = " ", key = "p" },
            { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            return {}
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  }
