" Install vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim plugin manager vim-plug To install new package :PlugInstall
call plug#begin('~/.vim/plugged')
  " Plug 'Valloric/YouCompleteMe' "Автодополнение
  Plug 'jiangmiao/auto-pairs' "Добавляет закрывающие скобки
  Plug 'airblade/vim-gitgutter' "Добавляет отображение изменённых в коммитах строчках
  Plug 'kien/ctrlp.vim' "Поиск по проекту ctrl+p
  Plug 'scrooloose/nerdtree' "Файловый менеджер
  Plug 'scrooloose/nerdcommenter' "Для быстрого комментирования
  Plug 'easymotion/vim-easymotion' "Крутая навигация по проекту

  "colorschemes
  Plug 'joshdick/onedark.vim' "Тема анологичная Atom
  Plug 'sheerun/vim-polyglot' "Плагин для подсветки синтаксиса
  Plug 'Yggdroot/indentLine' "Плагин для визуализации отступов

  " Plug 'vim-airline/vim-airline'
  Plug 'w0rp/ale' " Async Linter for eslint
  Plug 'editorconfig/editorconfig-vim' " to use .editorconfig

  " Deoplete autocomplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1

  " deoplete flow plugin
  Plug 'steelsojka/deoplete-flow'
  " npm install -g flow-bin
  " for work need 'flow init' in root of project

  " Move up and down in autocomplete with <c-j> and <c-k>
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")
call plug#end()

syntax on " add systax illumination
set colorcolumn=80
set clipboard=unnamedplus "make all yanking/deleting operations automatically copy to the system clipboard
set nu " add line numbers
set tabstop=2 "2 space on tab
set shiftwidth=2 "2 space for << and >>
set smarttab " delete tabstop spaces in the begining of aline on backspace instead of 1 space
set expandtab " change tabs on space in insert
set autoindent " copy indent for new line from previos

set hlsearch "illumination find results
set incsearch "Включить инкрементальный поиск

" Set block cursor for Cygwin
" let &t_SI.="\e[5 q"
" let &t_SR.="\e[4 q"
"let &t_EI.="\e[1 q"

 set keymap=russian-jcukenwin
 imap <C-F> <C-^>
 set iminsert=0
 set imsearch=0

"onedark
silent! colorscheme onedark "silent! - for fix error 'cant find color scheme onedark on first install

"Edit .vimrc
map ,v :vsp $MYVIMRC<CR>
if has("autocmd")
 autocmd! bufwritepost .vimrc source $MYVIMRC
endif

"NerdTree
map <C-n> :NERDTreeToggle<CR>

"NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" default leader is \
"vim-easymotion
" let g:mapleader=','
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

