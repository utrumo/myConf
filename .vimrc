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
" Plug 'neoclide/coc.nvim', {'tag': 'v0.0.79'}
" Plug 'neoclide/coc.nvim', {'commit': '757567b1dbe9c97f50ee7e9c421f7242f931e8f3'}
Plug 'vim-airline/vim-airline'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

Plug 'morhetz/gruvbox', { 'do': ':colorscheme gruvbox' }
" Plug 'joshdick/onedark.vim', { 'do': ':colorscheme onedark' } " Тема анологичная Atom
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
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'voldikss/vim-floaterm', { 'do': 'pip install neovim-remote' }

" nvim-tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

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

let g:coc_global_extensions = [
\  'coc-prettier',
\  'coc-json',
\  'coc-tsserver',
\  'coc-css',
\  'coc-cssmodules',
\  'coc-stylelintplus',
\  'coc-diagnostic',
\  'coc-emmet',
\  'coc-html',
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
" default leader is <Leader><Leader>
" default shortcats is <Leader>s, <Leader>gE.
 " map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" vim-closetag
" let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx,*.php'
" let g:closetag_close_shortcut = '<leader>>'

" Show special / NonText keys 
" with end of line symbol
" set list listchars=eol:↲,tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
" without end of line symbol
set list listchars=tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
let &showbreak='↳ '

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

 let g:gruvbox_italic = 1
colorscheme gruvbox
" autocmd vimenter * colorscheme gruvbox

" onedark
" if (has("autocmd"))
"   augroup colorextend
"     autocmd!
"     " Defoult NonText color:
"     " autocmd ColorScheme * call onedark#extend_highlight("NonText", { "fg": { "gui": "#3B4048" } })
"     " 25% Lighter:
"     autocmd ColorScheme * call onedark#extend_highlight("NonText", { "fg": { "gui": "#656E7C" } })
"   augroup END
" endif

" let g:onedark_terminal_italics=1
" colorscheme onedark 

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
set foldmethod=syntax
" set foldmethod=indent
set nofoldenable

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
nnoremap <LEADER>co :e ~/.vimrc<CR>
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
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

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
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
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

  " Remap keys for applying codeAction to the current buffer.
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

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

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

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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
  " let g:airline_theme='onedark'
  let g:airline_theme='gruvbox'

  let g:airline#extensions#keymap#enabled = '0'

  " Disables built-in gutentags
  let g:gutentags_enabled = 0

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""V
  " My custom mappings:
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" endf
" autocmd! User CocNvimInit call s:applyCocSettings()

" solve problem with freezed signs
" :nmap <silent> <leader>u :sign unplace *<CR>
"
:autocmd! BufWritePre *.js,*.jsx,*.ts,*.tsx,*.scss call CocAction('format')

" nvim-tree
" vimrc
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

lua << EOF
require'nvim-tree'.setup {
}
EOF
