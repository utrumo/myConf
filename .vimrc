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

"Plug 'w0rp/ale' " Async Linter for eslint
" Plug 'vim-airline/vim-airline'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'itchyny/lightline.vim'
Plug 'iamcco/diagnostic-languageserver', { 'do': 'yarn install --frozen-lockfile' }

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
Plug 'jeffkreeftmeijer/vim-numbertoggle' "Toggles between hybrid and absolute line numbers automatically 
Plug 'wesQ3/vim-windowswap'
call plug#end()

let g:coc_global_extensions = [
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\ ]

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" vim-easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" ale
" let g:ale_completion_enabled = 1
" let g:ale_set_balloons = 1
" let g:ale_linters = {
" \ 'php': ['phpcs']
" \ }
" let g:ale_fixers = {
" \ 'php': ['phpcbf']
" \ }
" let g:ale_php_phpcs_standard = 'PSR2'
" let g:ale_php_phpcbf_standard = 'PSR2'
" let g:ale_php_langserver_executable = $HOME.'/.config/composer/vendor/bin/php-language-server.php'

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" deoplete
" let g:deoplete#enable_at_startup = 1
" hide preview window after CompleteDone
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Move up and down in autocomplete with <c-j> and <c-k>
" inoremap <expr> <c-j> ("\<c-n>")
" inoremap <expr> <c-k> ("\<c-p>")

" onedark
  silent! colorscheme onedark "silent! - for fix error 'cant find color scheme onedark on first launch

" indentLine
let g:indentLine_leadingSpaceEnabled = 1

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

function! g:ToggleNuMode()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nmap <Leader>l :call g:ToggleNuMode()<CR> " Ctrl+l to toggle rnu

set tabstop=2 "2 space on tab
set shiftwidth=2 "2 space for << and >>
set expandtab " insert space characters whenever the tab key is pressed
set smarttab " delete tabstop spaces in the begining of aline on backspace instead of 1 space
set autoindent " copy indent for new line from previos
set smartindent

set ignorecase
set incsearch " Включить инкрементальный поиск
set hlsearch " highlight finded results
nnoremap <silent> <C-L> :nohlsearch<CR>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set scrolloff=1

set mouse=a
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
set confirm " disabled error on exit and ask to save

" Open vim config
"map <LEADER>oc :vsp $MYVIMRC<CR>
map <LEADER>oc :e ~/.vimrc<CR>
map <LEADER>occ :CocConfig<CR>
map <LEADER>pi :PlugInstall<CR>
map <LEADER>pu :PlugUpdate<CR>
map <LEADER>pc :PlugClean<CR>

"" set new config path
"let $MYVIMRC='~/.vimrc'

" autoreload vim config
if has("autocmd")
 autocmd! BufWritePost .vimrc,init.vim
 \ source $MYVIMRC |
 \ echo $MYVIMRC . "was reloaded"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" if hidden is not set, TextEdit might fail.
set hidden

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
