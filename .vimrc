" Install vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim plugin manager vim-plug To install new package :PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdcommenter' " Для быстрого комментирования
  Plug 'easymotion/vim-easymotion' " Крутая навигация по проекту
  Plug 'w0rp/ale' " Async Linter for eslint
  " Plug 'vim-airline/vim-airline'
  " Plug 'autozimu/LanguageClient-neovim', {
  " \ 'branch': 'next',
  " \ 'do': 'bash install.sh',
  " \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
  Plug 'joshdick/onedark.vim' " Тема анологичная Atom
  Plug 'Yggdroot/indentLine' "Плагин для визуализации отступов
  Plug 'airblade/vim-gitgutter' " Добавляет отображение изменённых в коммитах строчках
  Plug 'machakann/vim-sandwich'
  Plug 'alvan/vim-closetag' " Autoclose html tags by >
  Plug 'mattn/emmet-vim'
  Plug 'jiangmiao/auto-pairs' " Добавляет закрывающие скобки
  Plug 'editorconfig/editorconfig-vim' " to use .editorconfig
  " Plug 'ludovicchabant/vim-gutentags'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim' 
  Plug 'sheerun/vim-polyglot' " Плагин для подсветки синтаксиса
  Plug 'tpope/vim-eunuch' " Adds :Move command
  Plug 'qpkorr/vim-bufkill'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'wesQ3/vim-windowswap'
call plug#end()

" Ctrl+l to toggle rnu
function! g:ToggleNuMode()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

map <C-l> :call g:ToggleNuMode()<CR>
nmap <Leader>l :call g:ToggleNuMode()<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" vim-easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" ale
" let g:ale_linters = {
" \ 'php': ['phpcs']
" \ }
" let g:ale_fixers = {
" \ 'php': ['phpcbf']
" \ }
" let g:ale_php_phpcs_standard = 'PSR2'
" let g:ale_php_phpcbf_standard = 'PSR2'
let g:ale_completion_enabled = 1
" let g:ale_php_langserver_executable = $HOME.'/.config/composer/vendor/bin/php-language-server.php'

" LanguageClient-neovim
" set hidden " Required for operations modifying multiple buffers like rename.
" let g:LanguageClient_serverCommands = {
" \ 'javascript': ['javascript-typescript-stdio'],
" \ 'javascript.jsx': ['javascript-typescript-stdio'],
" \ 'php': ['php', $HOME.'/.config/composer/vendor/bin/php-language-server.php']
" \ }
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
" hide preview window after CompleteDone
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Move up and down in autocomplete with <c-j> and <c-k>
" inoremap <expr> <c-j> ("\<c-n>")
" inoremap <expr> <c-k> ("\<c-p>")

" onedark
silent! colorscheme onedark "silent! - for fix error 'cant find color scheme onedark on first launch

" indentLine
let g:indentLine_leadingSpaceEnabled = 1

" vim-sandwich
" let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
" let g:sandwich#recipes += [
"     \   {
"     \     'buns'    : ['TagInput(1)', 'TagInput(0)'],
"     \     'expr'    : 1,
"     \     'filetype': ['html'],
"     \     'kind'    : ['add', 'replace'],
"     \     'action'  : ['add'],
"     \     'input'   : ['t'],
"     \   },
"     \ ]

" function! TagInput(is_head) abort
"   if a:is_head
"     let s:TagLast = input('Tag: ')
"     if s:TagLast !=# ''
"       let tag = printf('<%s>', s:TagLast)
"     else
"       throw 'OperatorSandwichCancel'
"     endif
"   else
"     let tag = printf('</%s>', matchstr(s:TagLast, '^\a[^[:blank:]>/]*'))
"   endif
"   return tag
" endfunction

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.php'
let g:closetag_close_shortcut = '<leader>>'

" vim-gutentags
" let g:gutentags_project_root = ['node_modules', 'vendor']
" let g:gutentags_cache_dir = '~/.vim/gutentags'

" fzf
nmap <Leader>; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg!<CR>
nmap <Leader>c :Colors<CR>

" vim settings:
set colorcolumn=80
set number " add line numbers

set tabstop=2 "2 space on tab
set shiftwidth=2 "2 space for << and >>
" autocmd FileType php setlocal tabstop=4 shiftwidth=4
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

set mouse=a
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
set confirm " disabled error on exit and ask to save
" command! BD bp|bd# " delete buffer without losing the split window


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
" vim-polyglot
