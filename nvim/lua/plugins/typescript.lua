return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay_hints = { enabled = false },
      servers = {
        vtsls = {
          init_options = { hostInfo = "neovim" },
          settings = {
            typescript = {
              tsdk = "./.yarn/sdks/typescript/lib",
              -- @link https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
              inlayHints = {
                parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
              },
            },
          },
        },
      },
      setup = {
        vtsls = function(_, _opts)
          require("lazyvim.util").lsp.on_attach(function(client)
            -- disable vtsls formatting to prevent conflict with prettier
            if client.name == "vtsls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@class ConformOpts
    opts = {
      formatters = {
        prettier = {
          command = function(self, bufnr)
            local util = require("conform.util")
            -- use project wersion of prettier instead builtin
            local cmd = util.find_executable({ ".yarn/sdks/prettier/bin/prettier.cjs" }, "")(self, bufnr)

            if cmd ~= "" then
              return cmd
            end

            -- return type of util.from_node_modules is fun(self: conform.FormatterConfig, ctx: conform.Context): string
            ---@diagnostic disable-next-line
            return util.from_node_modules("prettier")(self, bufnr)
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function(_, _2)
      -- fix for multiple errors like:
      -- "Could not read source map for file:///home/devpa/Projects/work/zdravcity/backend/project/.yarn/cache/@babel-types-npm-7.22.19-693d56c802-2d69740e69.zip/node_modules/@babel/types/lib/definitions/typescript.js: ENOTDIR: not a directory, open '/home/devpa/Projects/work/zdravcity/backend/project/.yarn/cache/@babel-types-npm-7.22.19-693d56c802-2d69740e69.zip/node_modules/@babel/types/lib/definitions/typescript.js.map'"
      -- @link https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua#L244
      -- @link https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md#resolvesourcemaplocations-1
      local dap = require("dap")
      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      for _, language in ipairs(js_filetypes) do
        -- local launchFileConfig = dap.configurations[language][1]
        local attachConfig = dap.configurations[language][2]

        attachConfig.resolveSourceMapLocations = {
          "**",
          "!**/node_modules/**",
          "!**/.yarn/cache/**",
        }
        -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md#node-attach
        attachConfig.restart = true
        attachConfig.continueOnAttach = true
      end
      -- print(vim.inspect(dap.configurations))
      -- :messages
    end,
  },
}
