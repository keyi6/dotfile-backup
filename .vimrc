colorscheme ron 
set hls
set number
imap <C-j> <Down> 
set cindent
set smartindent
set autoindent
set showmatch
set showcmd
set autoread
set noexpandtab

set selection=exclusive
set t_Co=256
set selectmode=mouse,key
set tabstop=4
set softtabstop=4
set backspace=2
set shiftwidth=4
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set history=50

let python_highlight_all=1
syntax on


"******************************  Shortcut  ****************************** 
" plugin
map <F2> :NERDTreeToggle<CR>
map <F3> : ! gedit % <CR>

" text
map <C-A> ggVG
vmap <C-C> :w !pbcopy <CR><CR>

" compile and run
map <F9> : call CompileOrRun()<CR>
map <F5> : ! time ./%< <CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>

func! CompileOrRun()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -g -o %< -Wall"
	elseif &filetype == 'cpp'
		exec "!gcc % -g -o %< -Wall"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!python3 %"
	elseif &filetype == 'php'
		exec "!php %"
	elseif &filetype == 'js'
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

"******************************  Header  ****************************** 
au BufNewFile *.cpp exec ":call SetCpp()"
au BufNewFile *.php exec ":call SetPhp()"

func SetCpp()
	let l = 0
	let l = l + 1 | call setline(l, "#define PRON \"".expand("%<")."\"")
	let l = l + 1 | call setline(l, "#include <cstdio>")
	let l = l + 1 | call setline(l, "#include <vector>")
	let l = l + 1 | call setline(l, "#include <string>")
	let l = l + 1 | call setline(l, "#include <cstring>")
	let l = l + 1 | call setline(l, "#include <iostream>")
	let l = l + 1 | call setline(l, "#include <algorithm>")
	let l = l + 1 | call setline(l, "using namespace std;")
	let l = l + 1 | call setline(l, "typedef long long ll;")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "int main(){")
	let l = l + 1 | call setline(l, "#ifndef ONLINE_JUDGE")
	let l = l + 1 | call setline(l, "    freopen(PRON \".in\", \"r\", stdin);")
	let l = l + 1 | call setline(l, "    //freopen(PRON \".out\", \"w\", stdout);")
	let l = l + 1 | call setline(l, "#endif")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "}")
	exec ":%retab!"
	exec ":11"
endfunc

func SetPhp()
	let l = 0
	let l = l + 1 | call setline(l, "<?php")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "?>")
	exec ":%retab!"
	exec ":2"
endfunc


"******************************  Plugin  ****************************** 
set nocompatible			  " be iMproved, required
filetype off				  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()
filetype plugin indent on

" SimpylFold setting
"let g:SimpylFold_docstring_preview=1

" ale setting
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠️'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = { 
\	'c': 'clangcheck', 
\	'cpp': 'clangcheck', 
\	'python': ['flake8', 'mypy'],
\	'javascript': 'jslint',
\	'make': 'checkmake', 
\	'php': 'php', 
\	'sh': 'shellcheck',
\	'tex': 'chktex', 
\	'vim': 'vint', 
\}
let g:ale_fixers = {'python': ['trim_whitespace', 'autopep8']}

" airline and airline-theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" airline & ale
let g:airline#extensions#ale#enabled = 1
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_right(['ALE'])

" supertab setting
let g:SuperTabDefaultCompletionType = "context"

" jedi
let g:jedi#force_py_version=3
let g:pymode_rope = 0
let g:jedi#auto_initialization = 0
autocmd FileType python setlocal completeopt-=preview
let g:jedi#use_splits_not_buffers = "right"

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 3
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=lightgrey ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=130
