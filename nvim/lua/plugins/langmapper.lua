return {
  {
    "Wansmer/langmapper.nvim",
    enabled = false,
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require("langmapper").setup({ global = true, buffer = true })
    end,
  },
}
