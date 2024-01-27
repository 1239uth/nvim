-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require("lazyvim.util").safe_keymap_set

-- disable
map("n", "<leader>l", "<nop>") -- open Lazy
map("n", "<leader>cm", "<nop>") -- open Mason
map("n", "<leader>cl", "<nop>") -- LspInfo
map("n", "<leader>L", "<nop>") -- LazyVim changelog

-- add

map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- -- floating terminal
local Util = require("lazyvim.util")

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root(), border = "rounded" })
end
map("n", "…", lazyterm, { desc = "Terminal (root dir)" }) -- Option + ;
map("t", "…", "<cmd>close<cr>", { desc = "Hide Terminal" }) -- Option + ;
map("n", "Ú", lazyterm, { desc = "Terminal (root dir)" }) -- Option + Shift + ;
map("t", "Ú", "<cmd>close<cr>", { desc = "Hide Terminal" }) -- Option + Shift + ;

-- https://github.com/nvim-telescope/telescope.nvim/issues/964#issuecomment-1517629615
map("n", "<leader>fS", function()
  vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
    require("telescope.builtin").lsp_workspace_symbols({ query = query })
  end)
end, { desc = "LSP workspace symbols" })

--[[ Harpoon mappings ]]
-- stylua: ignore
if vim.bo["filetype"] ~= "rnvimr" then
  local harpoon = require("harpoon")
  map("n", "<leader>a", function() harpoon:list():append() end, { desc = "Harpoon add mark" })
  map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Toggle" })
  map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
  map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
  map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
  map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
  map("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
  map("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
  map("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "Harpoon 7" })
  map("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "Harpoon 8" })
  map("n", "<leader>9", function() harpoon:list():select(9) end, { desc = "Harpoon 9" })
  map("n", "<leader>0", function() harpoon:list():select(0) end, { desc = "Harpoon 0" })
end

-- [[ git diff mappings ]]
if vim.bo.filetype == "git" or vim.bo.filetype == "diff" then
  map("n", "<leader>1", ":diffget //2<cr>", { desc = "Git diff get 2" })
  map("n", "<leader>2", ":diffget //3<cr>", { desc = "Git diff get 3" })
end

-- Copilot + LuaSnip
map("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  elseif require("luasnip").jumpable(1) then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, false, true), "m", false)
  else
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Tab" })
