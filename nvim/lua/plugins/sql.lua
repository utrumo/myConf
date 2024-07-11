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
        table.insert(opts.formatters_by_ft[ft], "sql_formatter")
        -- opts.formatters_by_ft[ft] = { "sql_formatter" }
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
}
