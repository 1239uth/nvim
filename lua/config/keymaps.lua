-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local function disable(mode, key)
  vim.api.nvim_set_keymap(mode, key, "<Nop>", { noremap = true, silent = true })
end

disable("n", "<leader>l") -- open Lazy
disable("n", "<leader>cm") -- open Mason
disable("n", "<leader>cl") -- LspInfo
disable("n", "<leader>L") -- LazyVim changelog
disable("i", "<C-j>") -- default: move down in insert mode, redefined below

-- Remap arrow keys to print message to use hjkl
map("n", "<Up>", function()
  vim.notify("Use `k` instead up `Up Arrow`", "warn")
end, { desc = "Disable <Up> to use k instead" })
map("n", "<Down>", function()
  vim.notify("Use `j` instead up `Down Arrow`", "warn")
end, { desc = "Disable <Down> to use j instead" })
map("n", "<Left>", function()
  vim.notify("Use `h` instead of `Left Arrow`", "warn")
end, { desc = "Disable <Left> to use h instead" })
map("n", "<Right>", function()
  vim.notify("Use `l` instead of `Right Arrow`", "warn")
end, { desc = "Disable <Right> to use l instead" })

--[[ General Mappings ]]
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up", silent = true })

-- https://github.com/NvChad/NvChad/blob/8aec881517ae9e39990507f3bc7dfebfb38d531a/lua/core/mappings.lua#L73
vim.opt.clipboard = "unnamedplus"
-- map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without copying" })
map("x", "p", "pgv=gvy", { desc = "Paste without copying" })

-- Make :Q act like :q and :Qa act like :qa
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

vim.api.nvim_create_user_command("CodeiumChat", function()
  return vim.fn["codeium#Chat"]()
end, {})

-- https://github.com/nvim-telescope/telescope.nvim/issues/964#issuecomment-1517629615
-- Make a workspace symbol search take an input because it's broken with empty string
map("n", "<leader>fS", function()
  vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
    require("telescope.builtin").lsp_workspace_symbols({ query = query })
  end)
end, { desc = "LSP workspace symbols" })

--[[ Floating Terminal ]]
local Util = require("lazyvim.util")

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root(), border = "rounded" })
end
map("n", "…" --[[ Option + ; ]], lazyterm, { desc = "Terminal (root dir)" })
map("t", "…" --[[ Option + ; ]], "<cmd>close<cr>", { desc = "Hide Terminal" })
map("n", "Ú" --[[ Option + Shift + ; ]], lazyterm, { desc = "Terminal (root dir)" })
map("t", "Ú" --[[ Option + Shift + ; ]], "<cmd>close<cr>", { desc = "Hide Terminal" })
map("n", "<C-;>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<C-;>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- mapping to allow option backspace to act as ctrl w
vim.keymap.set("i", "<m-bs>", "<c-w>", { noremap = true, silent = true })
