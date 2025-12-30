local M = {}

-- Function to get song metadata
function M.get_song_info()
  local artist = vim.fn.system("playerctl metadata xesam:artist"):gsub("\n", "")
  local title = vim.fn.system("playerctl metadata xesam:title"):gsub("\n", "")
  local album = vim.fn.system("playerctl metadata xesam:album"):gsub("\n", "")

  -- Fetch the URL and try to extract playlist name
  local url = vim.fn.system("playerctl metadata xesam:url"):gsub("\n", "")
  local playlist = url:match("playlist/(.-)%?") or ""

  return artist, title, album, playlist
end

-- Function to show current song info
function M.show_song_info()
  local artist, title, album, playlist = M.get_song_info()

  if playlist == "" then
    local song_info = string.format("🎵 %s - %s | 💿 %s ", artist, title, album)
  else
    local song_info = string.format("🎵 %s - %s | 💿 %s | 📜 %s", artist, title, album, playlist)
  end

  -- Print metadata in one line
  print(song_info)
end

-- Keymaps
vim.keymap.set("n", "<leader>cp", function()
  vim.fn.system("playerctl play-pause")
  M.show_song_info()
end, { desc = "Toggle Play/Pause" })

vim.keymap.set("n", "<leader>cn", function()
  vim.fn.system("playerctl next")
  vim.fn.system("sleep 0.5") -- ✅ Wait for metadata update
  M.show_song_info()
end, { desc = "Next Track" })

vim.keymap.set("n", "<leader>cb", function()
  vim.fn.system("playerctl previous")
  vim.fn.system("sleep 0.5") -- ✅ Wait for metadata update
  M.show_song_info()
end, { desc = "Previous Track" })

vim.keymap.set("n", "<leader>ci", function()
  M.show_song_info() -- ✅ Always show current song
end, { desc = "Show Current Song" })

return M
