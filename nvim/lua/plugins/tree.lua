require('keybindings/utils')

local cmd = vim.api.nvim_command

nm('<C-n>', function() cmd('NvimTreeToggle') end)

require('nvim-tree').setup({
  view = {
    adaptive_size = true,
  },
})
