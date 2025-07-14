colorscheme jellybeans
set hls
set number
set cindent
set smartindent
set autoindent
set showmatch
set showcmd
set autoread
set relativenumber
set noexpandtab
set cursorline

set selection=exclusive
set t_Co=256
set selectmode=mouse,key
set foldmethod=marker
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set history=50

setlocal spell spelllang=en_us

syntax on
filetype plugin on
filetype indent on

"******************************  Auto Cmds ******************************
au VimEnter * highlight CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE
au VimEnter * highlight clear SpellBad | highlight SpellBad cterm=italic gui=italic
au VimEnter * highlight clear SpellCap | highlight SpellCap cterm=italic gui=italic
au VimEnter * highlight clear SpellLocal | highlight SpellLocal cterm=italic gui=italic

" remove trail when save
autocmd BufWritePre * call TrimWhitespace()
func! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" retab when save
autocmd BufWritePre * :retab

"******************************  Shortcut  ******************************
" compile and run
map <F9> : call CompileOrRun()<CR>
map <F5> : ! time ./%< <CR>

func! CompileOrRun()
    exec "w"
    let show_time_cmd = "!echo '\n\n\n============================ '`date` '============================' && "
    if &filetype == 'c'
        exec  show_time_cmd . "g++ % -g -o %< -Wall"
    elseif &filetype == 'cpp'
        exec show_time_cmd . "g++ % -g -o %< -Wall"
    elseif &filetype == 'sh'
        exec show_time_cmd . "./%"
    elseif &filetype == 'python'
        exec show_time_cmd . "python3 %"
    elseif &filetype == 'javascript'
        exec show_time_cmd . "node %"
    elseif &filetype == 'rust'
        exec show_time_cmd . "cargo run %"
    else
        echo &filetype . " filetype is not supported"
    endif
endfunc


" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" move in INSERT mode
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>


"******************************  Header  ******************************
au BufNewFile *.sh exec ":call SetSh()"
func SetSh()
    let l = 0
    let l = l + 1 | call setline(l, "#!/bin/bash")
endfunc


"******************************  Plugin  ******************************
" supertab setting
let g:SuperTabDefaultCompletionType = "context"

" vim-oscyank setting
" https://github.com/ojroques/vim-oscyank?tab=readme-ov-file
let g:oscyank_term = 'iTerm2'
nmap <C-c> <Plug>OSCYankOperator
vmap <C-c> <Plug>OSCYankVisual
