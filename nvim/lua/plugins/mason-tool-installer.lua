return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = false,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- now versions >= 4.0.0 are broken
      table.insert(opts.ensure_installed, { "typescript-language-server", version = "4.0.0" })
    end,
  },
}
