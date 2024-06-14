" tab width -> 4
set tabstop=4
" auto indent width -> 4
set shiftwidth=4
set softtabstop=0
" auto indent
set smartindent
set autoindent

set expandtab

" display line number
set number

" change title type
set title

" set character color
syntax on
colorscheme elflord

" highlight the line and column where the cursor exist
set cursorline
set cursorcolumn
" clear all highlight setting
highlight clear
" remove underline and set background color as 234 (see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
highlight CursorLine   cterm=NONE ctermbg=234
highlight CursorColumn cterm=NONE ctermbg=234
" color line number
" highlight CursorLineNr ctermfg=black ctermbg=grey

" automatically reflects updates of the opened file if it is written by others
set autoread

" max number of character -> 132 (follow Fortran free form)
set textwidth=132

" if file is grads script, insert (tabstop) spaces when tab key is pressed
"autocmd BufRead,BufNewFile *.gs set expandtab
autocmd BufRead,BufNewFile Makefile set noexpandtab

" always display status line
set laststatus=2
" display machine name
set statusline=\ [%{matchstr(hostname(),'\\w\\+')}]
" display filename (absolute path)
set statusline+=\ %F
" right alignment
set statusline+=%=
" display encoding type
" set statusline+=\ [%{&fileencoding}]
set statusline+=[%{&fileencoding}]
" present line / total line
set statusline+=[LINE:%l/%L]
" present column
set statusline+=[COLUMN:%c]

