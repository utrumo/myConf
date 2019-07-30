" Install vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | so $MYVIMRC
en

" autload changes in conf file
au! BufWritePost .vimrc,init.vim nested so $MYVIMRC

" load coc settnigs only if plugin installed
au! User CocNvimInit call s:applyCocSettings()

" Vim plugin manager vim-plug To install new package :PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter' " Для быстрого комментирования
Plug 'easymotion/vim-easymotion' " Крутая навигация по проекту

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

Plug 'joshdick/onedark.vim', { 'do': ':colorscheme onedark' } " Тема анологичная Atom
Plug 'Yggdroot/indentLine' " Плагин для визуализации отступов
Plug 'airblade/vim-gitgutter' " Добавляет отображение изменённых в коммитах строчках
Plug 'machakann/vim-sandwich'
Plug 'alvan/vim-closetag' " Autoclose html tags by >
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs' " Добавляет закрывающие скобки
Plug 'editorconfig/editorconfig-vim' " to use .editorconfig
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Plug 'airblade/vim-rooter' 
Plug 'sheerun/vim-polyglot' " Плагин для подсветки синтаксиса
Plug 'tpope/vim-eunuch' " Adds :Move command
Plug 'qpkorr/vim-bufkill'
Plug 'jeffkreeftmeijer/vim-numbertoggle' " Toggles between hybrid and absolute line numbers automaticallly 
Plug 'wesQ3/vim-windowswap'
cal plug#end()

let g:coc_global_extensions = [
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\  'coc-css',
\  'coc-stylelint',
\  'coc-emmet',
\  'coc-html',
\  'coc-diagnostic',
\  'coc-vetur',
\ ]

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" vim-easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" indentLine
" let g:indentLine_leadingSpaceEnabled = 1

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.php'
let g:closetag_close_shortcut = '<leader>>'

" onedark
if (has("termguicolors"))
  set termguicolors
endif
let g:onedark_terminal_italics=1
silent! colorscheme onedark 

" vim-rooter
" let g:rooter_patterns = ['node_modules/', '.git/']
" let g:rooter_manual_only = 0

" fzf
nmap <Leader>; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg!<CR>
nmap <Leader>c :Colors<CR>

" inoremap <Leader>nm <C-O>:call FindInNodeModules()<CR>

" function! FindInNodeModules()
"   let nodeModulesPath = FindRootDirectory() . "/node_modules"
"   if !isdirectory(nodeModulesPath)
"     echo nodeModulesPath . " is not found"
"     return
"   endif
"   :call fzf#vim#complete({
"   \ 'source': "find \| sed 's/^..//'",
"   \ "reducer": {lines -> join(lines, ', ')},
"   \ "options": "--multi --reverse",
"   \ "dir": nodeModulesPath,
"   \ "down": 20,
"   \})
" endfunction

" vim settings:
set colorcolumn=80
set number " add line numbers

function! g:ToggleNuMode()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunction
nmap <Leader>l :call g:ToggleNuMode()<CR> " to toggle rnu

" set new split positions
set splitbelow
set splitright

set tabstop=2 "2 space on tab
set shiftwidth=2 "2 space for << and >>
set smarttab " delete tabstop spaces in the begining of aline on backspace instead of 1 space
set expandtab " insert space characters whenever the tab key is pressed

set autoindent " copy indent for new line from previos
set smartindent

set ignorecase
set incsearch " Включить инкрементальный поиск
set hlsearch " highlight finded results
nnoremap <silent> <C-L> :nohlsearch<CR>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set scrolloff=5

set mouse=a
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
set confirm " disabled error on exit and ask to save

" Open vim config
map <LEADER>oc :e ~/.vimrc<CR>
map <LEADER>occ :CocConfig<CR>
map <LEADER>pi :PlugInstall<CR>
map <LEADER>pu :PlugUpdate<CR>
map <LEADER>pc :PlugClean<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fu! s:applyCocSettings()
  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " You will have bad experience for diagnostic messages when it's default 4000.
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

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
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
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add diagnostic info for https://github.com/itchyny/lightline.vim
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'relativepath', 'modified' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'relativepath', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }

  " reload lightline settings
  call lightline#disable() | call lightline#enable()

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


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

  " map eslint autofix
  nnoremap <silent> <leader>ef :CocCommand eslint.executeAutofix<CR>

  " map stylelint autofix
  nnoremap <silent> <leader>sf 
    \ :execute "!npx stylelint --fix " . expand('%')<bar>
    \ :echon "fixed"<CR>

  " fix highlighting for files with multiple languages (like vue)
  autocmd FileType vue syntax sync fromstart
endf
