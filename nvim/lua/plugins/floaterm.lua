local create_user_comand = vim.api.nvim_create_user_command

vim.g.floaterm_keymap_new = '<F7>'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F12>'

create_user_comand('Vifm', 'FloatermNew vifm', {})
