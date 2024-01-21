require('lualine').setup({
  sections = {
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(1, 8) end },
      'diff',
      'diagnostics',
    },
    lualine_c = {
      'filename',
      {
        'g:coc_status',
        fmt = function(str) return str:gsub('Prettier', ''):gsub('TSC %S+', ''):match('^%s*(.-)%s*$') end,
      },
    },
  },
})
