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

  Plug 'w0rp/ale' "Async Linter
call plug#end()

"YouCompleteMe
  "sudo apt-get install python-dev python3-dev
  "~/.vim/plugged/YouCompleteMe
  "./install.py --js-completer

syntax on "Подсветка синтаксиса
set number "Отображение номеров строк
set expandtab "За место tab используем пробелы
set tabstop=2 "В колчистве 2 штуки
set shiftwidth=2 "автоматический отступ
set hlsearch "Подсветка резуальтатов поиска
set incsearch "Включить инкрементальный поиск
set clipboard=unnamedplus "make all yanking/deleting operations automatically copy to the system clipboard

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
imap <C-F> <C-^>

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

"vim-easymotion
let g:mapleader=','
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" ale
let g:ale_linters = {
\   'javascript': ['standard'],
\}

