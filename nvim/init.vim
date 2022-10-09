" Install vim-plug if not exist
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
   !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim plugin manager vim-plug To install new package :PlugInstall
call plug#begin()
Plug 'scrooloose/nerdcommenter' " Для быстрого комментирования
Plug 'easymotion/vim-easymotion' " Крутая навигация по проекту

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

Plug 'airblade/vim-gitgutter' " Добавляет отображение изменённых в коммитах строчках
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'
Plug 'alvan/vim-closetag' " Autoclose html tags by >
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs' " Добавляет закрывающие скобки
Plug 'editorconfig/editorconfig-vim' " to use .editorconfig
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' 
Plug 'tpope/vim-eunuch' " Adds :Move command
Plug 'qpkorr/vim-bufkill'
Plug 'jeffkreeftmeijer/vim-numbertoggle' " Toggles between hybrid and absolute line numbers automaticallly 
Plug 'wesQ3/vim-windowswap'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'voldikss/vim-floaterm', { 'do': 'pip install neovim-remote' }
call plug#end()

lua << EOF
require('plugins/plugins')
EOF

" vim-floaterm
" Configuration example
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
command! Vifm FloatermNew vifm

" markdown
let g:mkdp_auto_start = 1
" markdown

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" autload changes in conf file
autocmd! BufWritePost .vimrc,init.vim nested source $MYVIMRC

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

" vim-closetag
" let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx,*.php'
" let g:closetag_close_shortcut = '<leader>>'

" Show special / NonText keys 
" with end of line symbol
" set list listchars=eol:↲,tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
" without end of line symbol
set list listchars=tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
let &showbreak='↳ '

" vim-rooter
" let g:rooter_patterns = ['Vagrantfile', 'node_modules/', '.git/']
let g:rooter_patterns = ['.git/']
let g:rooter_manual_only = 1

" fzf
" function! FindInNodeModulesAndIsert()
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
" inoremap <Leader>nm <C-O>:call FindInNodeModulesAndIsert()<CR>
"
function! s:FindInProject()
  :call fzf#run(fzf#wrap({
  \ "dir": FindRootDirectory(),
  \ 'source': "find -type f -not \\( -path './node_modules/*' -or  -path './.git/*' \\) \| sed 's/^..//'",
  \}))
endfunction
nmap <silent><Leader>rd :call <SID>FindInProject()<CR>

function! s:findIn(relativePath)
  let dir = FindRootDirectory() . a:relativePath

  if !isdirectory(dir)
    echo dir . " is not found"
    return
  endif

  execute 'Files' dir
endfunction

nnoremap <Leader>; :Buffers<CR>
" nnoremap <Leader>r :Tags<CR>

" current directory
nnoremap <Leader>t :Files<CR>
nnoremap <silent><Leader>nm :call <SID>findIn("/node_modules")<CR>
" nmap <silent><Leader>rd :execute 'Files' FindRootDirectory().'/src'<CR>
" nmap <silent><Leader>ts :call <SID>findInNodeModules("/src")<CR>
nnoremap <Leader>a :Rg!<CR>
nnoremap <Leader>c :Colors<CR>
nnoremap <Leader>m :Marks<CR>

function! s:processLine(line)
  execute 'cd' a:line
  " execute ':Files'
endfunction

function! s:change_dir(dir)
  " let source = 'find -type d -not \( -name .git -prune -o -name node_modules -prune \)'
  let source = 'find -type d -not \( -name .git -prune \)'
  call fzf#run({
    \ 'dir': a:dir,
    \ 'source': source,
    \ 'sink': {line -> s:processLine(line)}
    \ })
endfunction

nnoremap<silent><Leader>D :call <SID>change_dir(FindRootDirectory())<CR>
nnoremap<silent><Leader>d :call <SID>change_dir('.')<CR>

" vim settings:
set colorcolumn=100
autocmd FileType python set colorcolumn=80
autocmd FileType javascript set colorcolumn=100
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
set softtabstop=2
set shiftwidth=2 "2 space for << and >>
set smarttab " delete tabstop spaces in the begining of aline on backspace instead of 1 space
set expandtab " insert space characters whenever the tab key is pressed

" set autoindent " copy indent for new line from previos
set smartindent

set ignorecase
set incsearch " Включить инкрементальный поиск
set hlsearch " highlight finded results
nnoremap <silent> <C-L> :nohlsearch<CR>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set scrolloff=10

set mouse=a
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
set confirm " disabled error on exit and ask to save

" Open vim config
nnoremap <LEADER>co :e $MYVIMRC<CR>
nnoremap <Leader>cr :source $MYVIMRC<CR>
nnoremap <LEADER>cco :CocConfig<CR>
nnoremap <LEADER>col :CocOpenLog<CR>
nnoremap <LEADER>ci :CocInfo<CR>
nnoremap <LEADER>pi :PlugInstall<CR>
nnoremap <LEADER>pu :PlugUpdate<CR>
nnoremap <LEADER>pc :PlugClean<CR>

" Hack for lit-element / lit-html
nnoremap <silent><C-h> :call <SID>detectRegionFileType()<CR>
function! s:detectRegionFileType()
  let fileExt = expand('%:e')
  if fileExt != 'js'
    echo 'not a js file'
    return
  else
    echo 'filetype detected'
  endif

  if searchpair('css`', '', '\(css\)\@<!`', 'bnW') ||
  \  searchpair('<style', '', '</style>', 'bnW')
    set ft=css
  elseif searchpair('html`', '', '\(html\)\@<!`', 'bnW')
    set ft=html
  else
    set ft=javascript
  endif
endfunction

" Resize splits on window resize
au VimResized * wincmd =

" Disables built-in gutentags
" let g:gutentags_enabled = 0

" nnoremap <silent> <leader>ef :CocCommand eslint.executeAutofix<CR>
" \ :execute "!npx eslint --fix " . expand('%')<bar>
" \ :silent execute "!eslint_d --fix " . expand('%')<bar>

" :silent execute "!eslint_d --fix " . expand('%')
"  autocmd FileType javascript autocmd BufWritePost <buffer> noautocmd call FormatByEslint()
function! FormatByEslint()
  :silent execute "!eslint_d --fix " . expand('%:p')
  :edit
  :silent CocRestart
  :sign unplace *
  :echon " fixed"
endfunction

" map eslint autofix
nnoremap <leader>ef
 \ :write<bar>
 \ :call FormatByEslint()<CR>

" map stylelint autofix
"    \ :execute "!npx stylelint --fix " . expand('%')<bar>
nnoremap <leader>sf
  \ :write<bar>
  \ :silent execute "!npx stylelint --fix " . expand('%')<bar>
  \ :edit<bar>
  \ :echon "fixed"<CR>

nnoremap <leader>pf
  \ :write<bar>
  \ :silent execute "!npx prettier -w " . expand('%')<bar>
  \ :edit<bar>
  \ :echon "fixed"<CR>

" fix highlighting for files with multiple languages (like vue)
" autocmd FileType vue syntax sync fromstart
" autocmd FileType javascript syntax sync fromstart

" fix for coc-yaml
 let g:coc_filetype_map = {
 \ 'yaml.ansible': 'yaml',
 \ }

 " Reset coc hotkey
nmap <Leader>ccr
  \ :sign unplace *<CR>
  \ :CocRestart<CR>

" solve problem with freezed signs
" :nmap <silent> <leader>u :sign unplace *<CR>
"
:autocmd! BufWritePre *.js,*.jsx,*.ts,*.tsx,*.scss call CocAction('format')

" nvim-tree
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" Show commits for every source line (tpope/vim-fugitive)
nnoremap <Leader>gb :Git blame<CR> 

" vim-easymotion
" default leader is <Leader><Leader>
" default shortcats is <Leader>s, <Leader>gE.

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" <Leader>s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
