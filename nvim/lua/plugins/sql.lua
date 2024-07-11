return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = { "sql-formatter" },
  },
  {
    "stevearc/conform.nvim",
    ---@param opts ConformOpts
    opts = function(_, opts)
      for _, ft in ipairs({ "mysql", "plsql", "sql" }) do
        -- table.insert(opts.formatters_by_ft[ft], "sql_formatter")

        -- Temporary replaces sqlfluff to fix error in ~/.local/state/nvim/conform.log
        -- 14:24:13[ERROR] Formatter 'sqlfluff' error: WARNING    Fixes for LT09 not applied, as it would result in an unparsable file. Please report this as a bug with a minimal query which demonstrates this warning.
        --  [1 templating/parsing errors found]
        opts.formatters_by_ft[ft] = { "sql_formatter" }
      end

      -- @link https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/sql_formatter.lua
      opts.formatters.sql_formatter = {
        prepend_args = { "--config", vim.env.HOME .. "/sql-formatter.config.json" },
      }

      -- :lua print(vim.bo.filetype)
      -- print(vim.inspect(opts.formatters_by_ft))
      -- print(vim.inspect(opts.formatters))
      -- :ConformInfo
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      for key, value in ipairs(opts.ensure_installed) do
        -- fix for https://github.com/neovim/neovim/issues/29550
        if value == "sql" then
          table.remove(opts.ensure_installed, key)
          break
        end
      end
      -- print(vim.inspect(opts))
    end,
  },
}
