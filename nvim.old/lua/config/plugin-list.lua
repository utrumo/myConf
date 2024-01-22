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
  { 'lbrayner/vim-rzip' },
  {
    'williamboman/mason.nvim',
    config = function() require(CurrentDir .. 'plugin-configs/mason') end,
    build = ':MasonUpdate', -- :MasonUpdate updates registry contents
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function() require(CurrentDir .. 'plugin-configs/mason-lspconfig') end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require(CurrentDir .. 'plugin-configs/treesitter') end,
    build = ':TSUpdate',
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function() require(CurrentDir .. 'plugin-configs/ufo') end,
  },

  -- {
  -- 'jay-babu/mason-null-ls.nvim',
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- dependencies = {
  -- -- 'williamboman/mason.nvim',
  -- 'jose-elias-alvarez/null-ls.nvim',
  -- 'nvim-lua/plenary.nvim',
  -- },
  -- config = function() require(CurrentDir .. 'plugin-configs/mason-null-ls') end,
  -- },

  -- {
  -- 'nvimdev/guard.nvim',
  -- -- Builtin configuration, optional
  -- dependencies = { 'nvimdev/guard-collection' },
  -- config = function() require(CurrentDir .. 'plugin-configs/guard') end,
  -- },

  {
    'creativenull/efmls-configs-nvim',
    -- version = 'v1.x.x', -- version is optional, but recommended
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function() require(CurrentDir .. 'plugin-configs/efmls-configs-nvim') end,
  },

  'nvim-tree/nvim-web-devicons',

  {
    'nvimdev/lspsaga.nvim',
    lazy = true,
    branch = 'main',
    event = 'LspAttach',
    config = function() require(CurrentDir .. 'plugin-configs/lspsaga') end,
    dependencies = {
      -- { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      -- { "nvim-treesitter/nvim-treesitter" }
    },
  },

  {
    'hrsh7th/nvim-cmp',
    config = function() require(CurrentDir .. 'plugin-configs/cmp') end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lua',
    },
  },

  -- { 'neoclide/coc-neco', dependencies = { 'Shougo/neco-vim' } },
  -- {
  -- 'neoclide/coc.nvim',
  -- branch = 'release',
  -- config = function() require(CurrentDir .. 'plugin-configs/coc') end,
  -- },

  {
    'ellisonleao/gruvbox.nvim',
    config = function() require(CurrentDir .. 'plugin-configs/gruvbox') end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require(CurrentDir .. 'plugin-configs/tree') end,
  },

  {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
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
    config = function() require(CurrentDir .. 'plugin-configs/markdown-preview') end,
    build = function() vim.fn['mkdp#util#install']() end,
  },
  {
    'voldikss/vim-floaterm',
    config = function() require(CurrentDir .. 'plugin-configs/floaterm') end,
  },
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', build = './install --bin' },
      {
        'airblade/vim-rooter',
        config = function() require(CurrentDir .. 'plugin-configs/vim-rooter') end,
      },
    },
  },
  { 'towolf/vim-helm' },
})
