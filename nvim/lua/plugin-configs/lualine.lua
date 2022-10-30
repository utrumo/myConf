require('lualine').setup({
  sections = {
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(1, 8) end },
      'diff',
      'diagnostics',
      'g:coc_status',
    },
  },
})
