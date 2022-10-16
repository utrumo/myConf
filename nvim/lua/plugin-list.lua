local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use({ 'neoclide/coc-neco', requires = { 'Shougo/neco-vim' } })
  use({
    'neoclide/coc.nvim',
    branch = 'release',
    config = function() require('plugin-configs/coc') end,
  })
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function() require('plugin-configs/treesitter') end,
  })
  use({ 'ellisonleao/gruvbox.nvim', config = function() require('plugin-configs/gruvbox') end })
  use({
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugin-configs/tree') end,
  })
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugin-configs/lualine') end,
  })
  use({
    'easymotion/vim-easymotion',
    config = function() require('plugin-configs/easymotion') end,
  })
  use({
    'scrooloose/nerdcommenter',
    config = function() require('plugin-configs/nerdcommenter') end,
  })
  -- Добавляет отображение изменённых в коммитах строчках
  use('airblade/vim-gitgutter')
  use({ 'tpope/vim-fugitive', config = function() require('plugin-configs/vim-fugitive') end })
  use('machakann/vim-sandwich')
  -- Добавляет закрывающие скобки
  use('jiangmiao/auto-pairs')
  -- to use .editorconfig
  use('editorconfig/editorconfig-vim')
  -- Adds :Move command
  use('tpope/vim-eunuch')
  use('qpkorr/vim-bufkill')
  -- Toggles between hybrid and absolute line numbers automaticallly
  use('jeffkreeftmeijer/vim-numbertoggle')
  use('wesQ3/vim-windowswap')
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    config = function() require('plugin-configs/markdown-preview') end,
  })
  use({ 'voldikss/vim-floaterm', config = function() require('plugin-configs/floaterm') end })
  use({
    'junegunn/fzf.vim',
    requires = { { 'junegunn/fzf', run = ':call fzf#install()' }, 'airblade/vim-rooter' },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require('packer').sync() end
end)
