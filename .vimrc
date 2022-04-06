colorscheme ron 
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

syntax on
filetype plugin on
filetype indent on

au VimEnter * highlight CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE

"******************************  Shortcut  ****************************** 
" text
map <C-A> ggVG
vmap <C-C> :w !pbcopy <CR><CR>

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
	elseif &filetype == 'php'
		exec "!php %"
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

"******************************  Header  ****************************** 
au BufNewFile *.cpp exec ":call SetCpp()"
au BufNewFile *.php exec ":call SetPhp()"
au BufNewFile *.sh exec ":call SetSh()"

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
	let l = l + 1 | call setline(l, "int main() {")
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

func SetSh()
	let l = 0
	let l = l + 1 | call setline(l, "#!/bin/bash")
endfunc


"******************************  Plugin  ****************************** 
set nocompatible			  " be iMproved, required
filetype off				  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tell-k/vim-autopep8'
Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on

" NerdTree setting
map <f2> :NERDTreeToggle<CR>

" airline and airline-theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" supertab setting
let g:SuperTabDefaultCompletionType = "context"

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 4
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=lightgrey ctermbg=235

" latex-preview settings
let g:livepreview_engine = 'xelatex'
let g:livepreview_cursorhold_recompile = 0
let g:livepreview_previewer = 'open -a Preview'

" rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

