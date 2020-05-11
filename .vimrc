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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-stylelint', {'tag': '1.1.0', 'do': 'rm ./yarn.lock && yarn'}
Plug 'vim-airline/vim-airline'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

Plug 'joshdick/onedark.vim', { 'do': ':colorscheme onedark' } " Тема анологичная Atom
Plug 'airblade/vim-gitgutter' " Добавляет отображение изменённых в коммитах строчках
Plug 'machakann/vim-sandwich'
Plug 'alvan/vim-closetag' " Autoclose html tags by >
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs' " Добавляет закрывающие скобки
Plug 'editorconfig/editorconfig-vim' " to use .editorconfig
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' 
Plug 'sheerun/vim-polyglot' " Плагин для подсветки синтаксиса
Plug 'tpope/vim-eunuch' " Adds :Move command
Plug 'qpkorr/vim-bufkill'
Plug 'jeffkreeftmeijer/vim-numbertoggle' " Toggles between hybrid and absolute line numbers automaticallly 
Plug 'wesQ3/vim-windowswap'
call plug#end()

" \  'coc-stylelint',
let g:coc_global_extensions = [
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\  'coc-css',
\  'coc-diagnostic',
\  'coc-emmet',
\  'coc-html',
\  'coc-diagnostic',
\  'coc-vetur',
\  'coc-highlight',
\  'coc-yaml',
\  'coc-browser',
\  'coc-python'
\ ]

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

" vim-easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" vim-closetag
let g:closetag_filenames = '*.html,*.js,*.php'
let g:closetag_close_shortcut = '<leader>>'

" Show special / NonText keys 
set list listchars=eol:↲,tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
let &showbreak='↳ '

" onedark
if (has("termguicolors"))
  set termguicolors
endif

if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Defoult NonText color:
    " autocmd ColorScheme * call onedark#extend_highlight("NonText", { "fg": { "gui": "#3B4048" } })
    " 25% Lighter:
    autocmd ColorScheme * call onedark#extend_highlight("NonText", { "fg": { "gui": "#656E7C" } })
  augroup END
endif

let g:onedark_terminal_italics=1
colorscheme onedark 

" vim-rooter
let g:rooter_patterns = ['Vagrantfile', 'node_modules/', '.git/']
" let g:rooter_manual_only = 1

" fzf
nmap <Leader>; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg!<CR>
nmap <Leader>c :Colors<CR>
nmap <Leader>m :Marks<CR>

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
map <LEADER>ocl :CocOpenLog<CR>
map <LEADER>oci :CocInfo<CR>
map <LEADER>pi :PlugInstall<CR>
map <LEADER>pu :PlugUpdate<CR>
map <LEADER>pc :PlugClean<CR>

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

set foldmethod=syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! s:applyCocSettings()
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
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

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " vim-airline
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Enable/Disable coc integration
  let g:airline#extensions#coc#enabled = 1

  " Change error symbol:
  let airline#extensions#coc#error_symbol = 'E:'

  " Change warning symbol:
  let airline#extensions#coc#warning_symbol = 'W:'

  " Change error format:
  let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

  " Change warning format:
  let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

  " Change theme
  let g:airline_theme='onedark'

  let g:airline#extensions#keymap#enabled = '0'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " My custom mappings:
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " map eslint autofix
  nnoremap <silent> <leader>ef :CocCommand eslint.executeAutofix<CR>

  " map stylelint autofix
  nnoremap <silent> <leader>sf 
    \ :execute "!npx stylelint --fix " . expand('%')<bar>
    \ :echon "fixed"<CR>

  " fix highlighting for files with multiple languages (like vue)
  " autocmd FileType vue syntax sync fromstart
  " autocmd FileType javascript syntax sync fromstart

  " fix for coc-yaml
   let g:coc_filetype_map = {
   \ 'yaml.ansible': 'yaml',
   \ }
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" endf
" autocmd! User CocNvimInit call s:applyCocSettings()
