colorscheme ron 
set hls
set number
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
"set foldmethod=indent
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
	let l = l + 1 | call setline(l, "	 freopen(PRON \".in\", \"r\", stdin);")
	let l = l + 1 | call setline(l, "	 //freopen(PRON \".out\", \"w\", stdout);")
	let l = l + 1 | call setline(l, "#endif")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "}")
	exec ":11"
endfunc

func SetPhp()
	let l = 0
	let l = l + 1 | call setline(l, "<?php")
	let l = l + 1 | call setline(l, "")
	let l = l + 1 | call setline(l, "?>")
	exec ":2"
endfunc


"******************************  Plugin  ****************************** 
set nocompatible			  " be iMproved, required
filetype off				  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tmhedberg/SimpylFold'

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
let g:ale_statusline_format = ['✗ %d', '⚠️ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
set statusline=%F%m%r%h%w\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
let g:ale_linters = { 'reStructuredText': ['rstcheck'], 'c++': 'clang++', 'markdown': ['mdl'] }
let g:ale_fixers = {'python': ['trim_whitespace', 'autopep8']}

" youcompleteme setting
set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR>	   pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>	   pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>	   pumvisible() ? "\<C-p>" : "\<Up>"
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
let g:ycm_server_python_interpreter =  '/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" airline and airline-theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline#extensions#tabline#tab_nr_type = 1
