return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx", "vue" })
      end
    end,
  },

  -- LSP

  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "vue" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            volar = {},
          },
        },
      },
    },
    opts = {
      tsserver_plugins = {
        {
          name = "@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
        },
      },
      filetypes = { "typescript", "typescriptreact", "vue" },
    },
  },

  -- Disable tsserver with lspconfig since we're using typescript-tools.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {
      handlers = {
        function(server_name)
          if server_name == "tsserver" then
            return
          end
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vue-language-server" })
    end,
  },
  -- Utils
  {
    "dmmulroy/tsc.nvim",
    opts = {
      use_trouble_qflist = true,
      auto_focus_qflist = true,
    },
    cmd = "TSC",
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    opts = {},
    ft = { "typescript", "typescriptreact" },
  },

  -- DAP (Debugger)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
}
