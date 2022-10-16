:lua require('plugin-list')

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" autload changes in conf file
autocmd! BufWritePost .vimrc,init.vim nested source $MYVIMRC

" Show special / NonText keys 
" with end of line symbol
" set list listchars=eol:↲,tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
" without end of line symbol
set list listchars=tab:»\ ,space:·,trail:•,extends:›,precedes:‹,conceal:*,nbsp:␣
let &showbreak='↳ '

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
nnoremap <LEADER>pi :PackerInstall<CR>
nnoremap <LEADER>pu :PackerSync<CR>
nnoremap <LEADER>cpu :CocUpdate<CR>
nnoremap <LEADER>tpu :TSUpdate<CR>
nnoremap <LEADER>pc :PackerClean<CR>

" Resize splits on window resize
autocmd VimResized * wincmd =
