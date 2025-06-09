olorscheme ron
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
set tabstop=4
set foldmethod=marker
set softtabstop=4
set backspace=2
set shiftwidth=4
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set history=50

setlocal spell spelllang=en_us

syntax on
filetype plugin on
filetype indent on

au VimEnter * highlight CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE

"******************************  Shortcut  ******************************
" compile and run
map <F9> : call CompileOrRun()<CR>
map <F5> : ! time ./%< <CR>

func! CompileOrRun()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -g -o %< -Wall"
	elseif &filetype == 'cpp'
		exec "!g++ % -g -o %< -Wall"
	elseif &filetype == 'sh'
		exec "!./%"
	elseif &filetype == 'python'
		exec "!python3 %"
	elseif &filetype == 'javascript'
		exec "!node %"
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


"******************************  Plugin  ******************************
" supertab setting
" https://github.com/ervandew/supertab
let g:SuperTabDefaultCompletionType = "context"

" vim-oscyank setting
" https://github.com/ojroques/vim-oscyank?tab=readme-ov-file
let g:oscyank_term = 'iTerm2'
nmap <C-c> <Plug>OSCYankOperator
vmap <C-c> <Plug>OSCYankVisual
