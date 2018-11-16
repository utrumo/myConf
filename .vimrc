" Install vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim plugin manager vim-plug To install new package :PlugInstall
call plug#begin('~/.vim/plugged')
  " Plug 'kien/ctrlp.vim' " Поиск по проекту ctrl+p

  " Plug 'scrooloose/nerdtree' " Файловый менеджер
  " map <C-n> :NERDTreeToggle<CR>

  Plug 'scrooloose/nerdcommenter' " Для быстрого комментирования
  let g:NERDSpaceDelims = 1
  let g:NERDDefaultAlign = 'left'

  Plug 'easymotion/vim-easymotion' " Крутая навигация по проекту
  " map  <Leader>f <Plug>(easymotion-bd-f)
  " nmap <Leader>f <Plug>(easymotion-overwin-f)

  Plug 'w0rp/ale' " Async Linter for eslint
  let g:ale_linters = {
  \ 'php': ['phpcs']
  \ }
  let g:ale_fixers = {
  \ 'php': ['phpcbf']
  \ }
  let g:ale_php_phpcs_standard = 'PSR2'
  let g:ale_php_phpcbf_standard = 'PSR2'
  " let g:ale_completion_enabled = 1
  " let g:ale_php_langserver_executable = $HOME.'/.config/composer/vendor/bin/php-language-server.php'

  " Plug 'vim-airline/vim-airline'

  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
	set hidden " Required for operations modifying multiple buffers like rename.
	let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'php' : ['tags']
  \ }
	nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
	nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
	nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

  " Deoplete autocomplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " hide preview window after CompleteDone
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  " Move up and down in autocomplete with <c-j> and <c-k>
  " inoremap <expr> <c-j> ("\<c-n>")
  " inoremap <expr> <c-k> ("\<c-p>")

  Plug 'joshdick/onedark.vim' " Тема анологичная Atom
  Plug 'Yggdroot/indentLine' "Плагин для визуализации отступов
  let g:indentLine_leadingSpaceEnabled = 1
  Plug 'airblade/vim-gitgutter' " Добавляет отображение изменённых в коммитах строчках
  Plug 'machakann/vim-sandwich'
  
  Plug 'jiangmiao/auto-pairs' " Добавляет закрывающие скобки
  Plug 'editorconfig/editorconfig-vim' " to use .editorconfig

  Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_project_root = ['node_modules', 'vendor']
  let g:gutentags_cache_dir = '~/.vim/gutentags'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim' 

	" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
	nmap ; :Buffers<CR>
	nmap <Leader>r :Tags<CR>
	nmap <Leader>t :Files<CR>
	nmap <Leader>a :Rg!<CR>
	nmap <Leader>c :Colors<CR>

  Plug 'sheerun/vim-polyglot' "Плагин для подсветки синтаксиса
  syntax on
call plug#end()

silent! colorscheme onedark "silent! - for fix error 'cant find color scheme onedark on first install
set colorcolumn=80
set number " add line numbers

set tabstop=2 "2 space on tab
set shiftwidth=2 "2 space for << and >>
autocmd FileType php setlocal tabstop=4 shiftwidth=4
set expandtab " insert space characters whenever the tab key is pressed
set smarttab " delete tabstop spaces in the begining of aline on backspace instead of 1 space
set autoindent " copy indent for new line from previos
set smartindent

set hlsearch " highlight finded results
set incsearch " Включить инкрементальный поиск
set ignorecase

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" imap <C-F> <C-^>
"
set mouse=a
tnoremap <Esc> <C-\><C-n>
set confirm " disabled error on exit and ask to save
" set clipboard=unnamedplus "make all yanking/deleting operations automatically copy to the system clipboard
" autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")

" Edit .vimrc
" map ,v :vsp $MYVIMRC<CR>
" if has("autocmd")
"  autocmd! bufwritepost .vimrc source $MYVIMRC
" endif

" default leader is \
" let g:mapleader=','

" Set block cursor for Cygwin
" let &t_SI.="\e[5 q"
" let &t_SR.="\e[4 q"
" let &t_EI.="\e[1 q"
