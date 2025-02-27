return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      print("🔍 hgdiff.lua loaded!")
  
      -- Define signs for Mercurial changes
      vim.fn.sign_define("HgAdd", { text = "│", texthl = "DiffAdd", numhl = "" })
      vim.fn.sign_define("HgChange", { text = "│", texthl = "DiffChange", numhl = "" })
      vim.fn.sign_define("HgDelete", { text = "_", texthl = "DiffDelete", numhl = "" })
  
      local function highlight_hg_changes()
        print("🚀 Running hg diff highlight...")
  
        local file = vim.fn.expand("%")
        if file == "" then
          print("⚠ No file detected.")
          return
        end
  
        vim.fn.jobstart({ "hg", "diff", "--unified", file }, {
          stdout_buffered = true,
          on_stdout = function(_, data)
            if not data or vim.tbl_isempty(data) then
              print("⚠ No changes detected by hg diff.")
              return
            end
  
            local bufnr = vim.api.nvim_get_current_buf()
  
            -- Clear old signs
            vim.fn.sign_unplace("hg_signs", { buffer = bufnr })
  
            print("🔎 Processing diff output...") -- Debugging statement
  
            for _, line in ipairs(data) do
              print("📌 Diff line: " .. line) -- Debugging each line
  
              local ln = line:match("^@@ %-%d+,%d+ %+(%d+),%d+ @@")
              if ln then
                local lnum = tonumber(ln)
  
                if line:find("^%+") then
                  print("🟢 Added line: " .. lnum)
                  vim.fn.sign_place(0, "hg_signs", "HgAdd", bufnr, { lnum = lnum })
                elseif line:find("^%-") then
                  print("🔴 Deleted line: " .. lnum)
                  vim.fn.sign_place(0, "hg_signs", "HgDelete", bufnr, { lnum = lnum })
                else
                  print("🟡 Modified line: " .. lnum)
                  vim.fn.sign_place(0, "hg_signs", "HgChange", bufnr, { lnum = lnum })
                end
              end
            end
          end,
        })
      end
  
      -- Auto-run `hg diff` when entering a buffer
      vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
        callback = highlight_hg_changes,
      })
  
      -- ✅ Toggle Mercurial Diff Signs
      vim.keymap.set("n", "<leader>ht", function()
        print("🔥 Keymap <leader>ht triggered!")
        highlight_hg_changes()
      end, { desc = "Toggle HG Changes", noremap = true, silent = true })
    end,
  }
  