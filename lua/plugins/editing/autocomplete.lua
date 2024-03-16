-- override default nvim-cmp to add border around the completion window
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.window = {
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

  -- this is for copilot in autocomplete menu, don't need this since using ghost text
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },

  {
    "L3MON4D3/LuaSnip",
    -- disable the tab key here and enable it in keymaps.lua
    keys = function()
      return {}
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      keymap = {
        -- overriden in keymaps.lua
        accept = false,
        accept_word = false,
        accept_line = false,
        next = false,
        prev = false,
        dismiss = false,
      },
    },
    init = function()
      local function copilot_active()
        if not package.loaded["copilot"] then
          return
        end
        local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
        if not ok then
          return false
        end
        return ok and #clients > 0
      end

      -- Copilot keymaps

      -- Toggle copilot on/off
      vim.keymap.set("n", "<leader>uo", function()
        if copilot_active() then
          vim.cmd("Copilot disable")
          vim.notify("Copilot disabled", "info")
        else
          vim.cmd("Copilot enable")
          vim.notify("Copilot enabled", "info")
        end
      end, { desc = "Toggle copilot" })

      -- Accept copilot suggestion
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Tab, or accept copilot" })

      -- Accept single word
      vim.keymap.set("i", "¬" --[[ Option + l ]], function()
        require("copilot.suggestion").accept_word()
      end, { desc = "Copilot accept single word" })

      -- Cycle through suggestions
      vim.keymap.set("i", "<C-j>", function()
        require("copilot.suggestion").next()
      end, { desc = "Copilot next suggestion" })

      -- Disable copilot and cmp
      vim.keymap.set("i", "<C-e>", function()
        require("copilot.suggestion").dismiss()
        require("cmp").mapping.abort()
      end, { desc = "Close autocomplete and dismiss copilot" })
    end,
  },
}
