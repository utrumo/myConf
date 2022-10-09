local keymap = vim.api.nvim_set_keymap

vim.g.EasyMotion_smartcase = 1

keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
