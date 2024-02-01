return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.auto_expand_width = true

      -- opts.event_handlers = opts.event_handlers or {}
      -- table.insert(opts.event_handlers, {
      --   event = "neo_tree_buffer_enter",
      --   handler = function()
      --     vim.opt_local.relativenumber = true
      --   end,
      -- })
    end,
  },
}
