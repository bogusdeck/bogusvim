local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Get list of changed files with status (M, A, R, etc.)
local function get_hg_changed_files()
  local output = vim.fn.systemlist("hg status")
  local files = {}
  for _, line in ipairs(output) do
    local status = line:sub(1, 1)
    local file = line:sub(3)
    table.insert(files, {
      value = file,
      display = string.format("[%s] %s", status, file),
      ordinal = file,
      status = status
    })
  end
  return files
end

-- Show diff in a floating window
local function show_diff(file)
  local diff_output = vim.fn.systemlist("hg diff " .. vim.fn.shellescape(file))
  
  -- Create a floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded"
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, diff_output)
  vim.bo[buf].filetype = "diff"
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  
  -- Add quit mapping
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(buf, "n", "<ESC>", ":q<CR>", {noremap = true, silent = true})
end

function M.open_hg_changes()
  local files = get_hg_changed_files()
  if #files == 0 then
    vim.notify("No changed files in Mercurial", vim.log.levels.INFO)
    return
  end

  pickers.new({}, {
    prompt_title = "Mercurial Changed Files",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.ordinal,
          status = entry.status
        }
      end
    }),
    sorter = conf.generic_sorter({}),
    previewer = false,
    attach_mappings = function(prompt_bufnr, map)
      -- Open diff on <CR>
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        show_diff(selection.value)
      end)
      
      -- Additional mappings
      map("i", "<CR>", actions.select_default)
      map("n", "<CR>", actions.select_default)
      
      return true
    end,
  }):find()
end

return M