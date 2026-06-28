vim.opt_local.conceallevel = 3
vim.opt_local.concealcursor = ""

local group = vim.api.nvim_create_augroup("MarkdownRenderModeConceal", { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
local markdown_buf = vim.api.nvim_get_current_buf()

local function update_markdown_render(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  local render = vim.api.nvim_get_mode().mode == "n"
  local conceallevel = render and 3 or 0

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_set_option_value("conceallevel", conceallevel, { win = win })
      vim.api.nvim_set_option_value("concealcursor", "", { win = win })
    end
  end

  local ok, render_markdown = pcall(require, "render-markdown")
  if ok then
    render_markdown.render({
      buf = buf,
      event = "MarkdownRenderModeConceal",
    })
  end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "ModeChanged", "BufEnter", "BufWinEnter" }, {
  group = group,
  buffer = 0,
  callback = function(args)
    local buf = args.buf
    vim.schedule(function()
      update_markdown_render(buf)
    end)
  end,
})

vim.schedule(function()
  update_markdown_render(markdown_buf)
end)

vim.defer_fn(function()
  update_markdown_render(markdown_buf)
end, 100)

vim.defer_fn(function()
  update_markdown_render(markdown_buf)
end, 500)
