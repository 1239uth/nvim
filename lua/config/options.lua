-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
  },
})

vim.opt.mousescroll = "ver:1,hor:6" -- Default: "ver:3,hor:6"

-- Add the following options to make tailwind classes more visually appealing
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

vim.filetype.add({
  pattern = {
    ["Make.*"] = "make",
  },
  extension = {
    ["h"] = "c", -- .h files should be treated as C files, not C++ files
  },
})
