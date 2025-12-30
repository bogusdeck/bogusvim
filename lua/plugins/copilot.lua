-- return {
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     build = ":Copilot auth", -- optional, runs after install
--     event = "InsertEnter",
--     config = function()
--       require("copilot").setup({
--         suggestion = {
--           enabled = true,
--           auto_trigger = true,
--           keymap = {
--             accept = "<Tab>",
--             next = "<M-]>",
--             prev = "<M-[>",
--             dismiss = "<C-]>",
--           },
--         },
--         panel = { enabled = true },
--         filetypes = {
--           ["*"] = true,
--           markdown = false,
--           help = false,
--           gitcommit = false,
--           gitrebase = false,
--         },
--       })
--     end,
--   },
-- }
--
return
{
    "github/copilot.vim",
}
