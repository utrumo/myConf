local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

require('nvim-tree').setup({
  view = {
    adaptive_size = true,
  },
})
