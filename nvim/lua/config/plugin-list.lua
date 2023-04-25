local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
CurrentDir = (...):match('(.*[/\\])')

require('lazy').setup({
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function() require(CurrentDir .. 'plugin-configs/mason') end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function() require(CurrentDir .. 'plugin-configs/mason-lspconfig') end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function() require(CurrentDir .. 'plugin-configs/lspconfig') end,
  },

  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },
  { 'hrsh7th/cmp-nvim-lua' },
  {
    'hrsh7th/nvim-cmp',
    config = function() require(CurrentDir .. 'plugin-configs/cmp') end,
  },

  { 'neoclide/coc-neco', dependencies = { 'Shougo/neco-vim' } },
  -- {
  -- 'neoclide/coc.nvim',
  -- branch = 'release',
  -- config = function() require(CurrentDir .. 'plugin-configs/coc') end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local tsUpdate = require('nvim-treesitter.install').update({ with_sync = true })
      tsUpdate()
    end,
    config = function() require(CurrentDir .. 'plugin-configs/treesitter') end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    config = function() require(CurrentDir .. 'plugin-configs/gruvbox') end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require(CurrentDir .. 'plugin-configs/tree') end,
  },

  {
    'glepnir/lspsaga.nvim',
    lazy = true,
    branch = 'main',
    event = 'LspAttach',
    config = function() require(CurrentDir .. 'plugin-configs/lspsaga') end,
    -- dependencies = {
    -- {"nvim-tree/nvim-web-devicons"},
    -- --Please make sure you install markdown and markdown_inline parser
    -- {"nvim-treesitter/nvim-treesitter"}
    -- }
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function() require(CurrentDir .. 'plugin-configs/mason-null-ls') end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    config = function() require(CurrentDir .. 'plugin-configs/lualine') end,
  },
  {
    'easymotion/vim-easymotion',
    config = function() require(CurrentDir .. 'plugin-configs/easymotion') end,
  },
  {
    'scrooloose/nerdcommenter',
    config = function() require(CurrentDir .. 'plugin-configs/nerdcommenter') end,
  },
  -- Добавляет отображение изменённых в коммитах строчках
  'airblade/vim-gitgutter',
  {
    'tpope/vim-fugitive',
    config = function() require(CurrentDir .. 'plugin-configs/vim-fugitive') end,
  },
  'machakann/vim-sandwich',
  -- Добавляет закрывающие скобки
  'jiangmiao/auto-pairs',
  -- to use .editorconfig
  'editorconfig/editorconfig-vim',
  -- Adds :Move command
  'tpope/vim-eunuch',
  'qpkorr/vim-bufkill',
  -- Toggles between hybrid and absolute line numbers automaticallly
  'jeffkreeftmeijer/vim-numbertoggle',
  'wesQ3/vim-windowswap',
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn['mkdp#util#install']() end,
    config = function() require(CurrentDir .. 'plugin-configs/markdown-preview') end,
  },
  {
    'voldikss/vim-floaterm',
    config = function() require(CurrentDir .. 'plugin-configs/floaterm') end,
  },
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', build = './install --all' },
      {
        'airblade/vim-rooter',
        config = function() require(CurrentDir .. 'plugin-configs/vim-rooter') end,
      },
    },
  },
})
