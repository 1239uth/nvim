-- override default nvim-cmp to add border around the completion window
return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    init = function()
      vim.keymap.set("i", "<c-j>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-k>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-e>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "LazyFile",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --     },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       yaml = true,
  --       help = true,
  --     },
  --     keymap = {
  --       -- overriden in keymaps.lua
  --       accept = false,
  --       accept_word = false,
  --       accept_line = false,
  --       next = false,
  --       prev = false,
  --       dismiss = false,
  --     },
  --   },
  --   init = function()
  --     local function copilot_active()
  --       if not package.loaded["copilot"] then
  --         return
  --       end
  --       local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
  --       if not ok then
  --         return false
  --       end
  --       return ok and #clients > 0
  --     end
  --
  --     -- Copilot keymaps
  --
  --     -- Toggle copilot on/off
  --     vim.keymap.set("n", "<leader>ct", function()
  --       if copilot_active() then
  --         vim.cmd("Copilot disable")
  --         vim.notify("Copilot disabled", "info")
  --       else
  --         vim.cmd("Copilot enable")
  --         vim.notify("Copilot enabled", "info")
  --       end
  --     end, { desc = "Toggle copilot" })
  --
  --     -- Accept copilot suggestion
  --     vim.keymap.set("i", "<Tab>", function()
  --       if require("copilot.suggestion").is_visible() then
  --         require("copilot.suggestion").accept()
  --       else
  --         return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  --       end
  --     end, { desc = "Tab, or accept copilot" })
  --
  --     -- Accept single word
  --     vim.keymap.set("i", "¬" --[[ Option + l ]], function()
  --       require("copilot.suggestion").accept_word()
  --     end, { desc = "Copilot accept single word" })
  --
  --     -- Cycle through suggestions
  --     vim.keymap.set("i", "<C-j>", function()
  --       require("copilot.suggestion").next()
  --     end, { desc = "Copilot next suggestion" })
  --
  --     -- Disable copilot and cmp
  --     vim.keymap.set("i", "<C-e>", function()
  --       require("copilot.suggestion").dismiss()
  --       require("cmp").mapping.abort()
  --     end, { desc = "Close autocomplete and dismiss copilot" })
  --   end,
  -- },
  --
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- disable the tab key here and enable it in copilot settings
  --   keys = function()
  --     return {}
  --   end,
  -- },
  --
  -- -- Copilot in lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local colors = {
  --       [""] = LazyVim.ui.fg("Special"),
  --       ["Normal"] = LazyVim.ui.fg("Special"),
  --       ["Warning"] = LazyVim.ui.fg("DiagnosticError"),
  --       ["InProgress"] = LazyVim.ui.fg("DiagnosticWarn"),
  --     }
  --     table.insert(opts.sections.lualine_x, 2, {
  --       function()
  --         local icon = require("lazyvim.config").icons.kinds.Copilot
  --         local status = require("copilot.api").status.data
  --         return icon .. (status.message or "")
  --       end,
  --       cond = function()
  --         if not package.loaded["copilot"] then
  --           return
  --         end
  --         local ok, clients = pcall(LazyVim.lsp.get_clients, { name = "copilot", bufnr = 0 })
  --         if not ok then
  --           return false
  --         end
  --         return ok and #clients > 0
  --       end,
  --       color = function()
  --         if not package.loaded["copilot"] then
  --           return
  --         end
  --         local status = require("copilot.api").status.data
  --         return colors[status.status] or colors[""]
  --       end,
  --     })
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    -- disable the tab key here and enable it in copilot settings
    keys = function()
      return {}
    end,
    opts = function(_, opts)
      opts.window = {
        -- add border around completion window
        completion = require("cmp").config.window.bordered(),
        documentation = require("cmp").config.window.bordered(),
      }
      -- disable ghost text for autocomplete since copilot is using ghost text
      opts.experimental = {
        ghost_text = false,
      }
      return opts
    end,
  },
}
