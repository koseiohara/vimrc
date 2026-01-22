let mapleader = " "
" tab width -> 4
set tabstop=4
" auto indent width -> 4
set shiftwidth=4
set softtabstop=0
" auto indent
set smartindent
set autoindent

" The Maximum Number of Tab Pages (Default : 10)
set tabpagemax=50

" rewrite some commands
nnoremap <S-h> ^
nnoremap <S-l> $
nnoremap <S-k> gg
nnoremap <S-j> G
nnoremap <C-h> 10h
nnoremap <C-l> 10l
nnoremap <C-k> 10k
nnoremap <C-j> 10j
nnoremap <Leader>b %
nnoremap x "_x
nnoremap s "_s
nnoremap ; :
nnoremap <Leader>q q:
nnoremap  q: <Nop>

nnoremap <Leader>n :set relativenumber!<CR>

" keymaps for multi-tab
nnoremap <silent> <Tab>   :tabnext<CR>
nnoremap <silent> <S-Tab> :tabprevious<CR>
nnoremap <Leader>topen    :tabnew 

" keymaps for multi-window
nnoremap <Right> :wincmd l<CR>
nnoremap <Left>  :wincmd h<CR>
nnoremap <Up>    :wincmd k<CR>
nnoremap <Down>  :wincmd j<CR>
nnoremap <silent> <Leader>vs :vsplit<CR>
nnoremap <silent> <Leader>hs :split<CR>
nnoremap <Leader>vopen :vsplit 
nnoremap <Leader>hopen :split 
nnoremap <silent> <Leader><BS> :close<CR>
nnoremap <silent> <Leader>l  <C-w>><CR>
nnoremap <silent> <Leader>h  <C-w><<CR>
nnoremap <silent> <Leader>k  <C-w>+<CR>
nnoremap <silent> <Leader>j  <C-w>-<CR>
nnoremap <silent> <Leader>eq <C-w>=<CR>

inoremap kj <Esc>
inoremap Kj <Esc>
inoremap KJ <Esc>

inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-j> <Down>

" keep visual mode when < or > is executed
vnoremap < <gv
vnoremap > >gv


command! -nargs=* Show call ShowLines(<f-args>)
cabbrev show Show
command! Rpl call s:ReplaceHighlighted()
cabbrev rpl Rpl

command! Reln set relativenumber
command! Noreln set norelativenumber
cabbrev reln Reln
cabbrev noreln Noreln


" 2 additional lines will always be displaied
set scrolloff=2
" Tab to spaces
set expandtab
" display line number
set number relativenumber
set numberwidth=5
" set character color
syntax on
colorscheme elflord


" remember fold information and cursor position
set foldmethod=indent
set foldcolumn=1
set foldlevelstart=99
set viewoptions=folds,cursor
augroup RememberFolds
    autocmd!
    autocmd BufWinLeave * silent! mkview
    autocmd BufWinEnter * silent! loadview
augroup END


autocmd BufRead,BufNewFile Makefile set noexpandtab
autocmd BufRead,BufNewFile *.nml set filetype=fortran
augroup start_at_first_line
  autocmd!
  autocmd FileType gitcommit setlocal viewoptions=
  autocmd FileType gitcommit execute 'normal! gg'
augroup END



" automatically reflects updates of the opened file if it is written by others
set autoread

" max number of character -> 132 (follow Fortran free form)
set textwidth=0
autocmd BufRead,BufNewFile *.f90 set textwidth=132


" always display status line
set laststatus=2
set statusline=%!MyStatusLine()


" change title type
set title
set titlestring=[%{matchstr(hostname(),'\\w\\+')}]
set titlestring+=\ [%F]


set showtabline=2


" function! ShowLines(startline, nlines)
function! ShowLines(...)
    let args = a:000
    if (len(args) < 1)
        echo getline('.')
        return
    endif
    let startline = str2nr(args[0])
    " let nline = (len(args) >= 2 ? str2nr(args[1]) : 1)
    " let endline = startline + nline - 1
    let endline = (len(args) >= 2 ? str2nr(args[1]) : l:startline)
    echo join(getline(startline, endline), "\n")
endfunction


function! s:ReplaceHighlighted()
    let l:old = getreg('/')
    if (l:old[0:1] == '\<' && l:old[-2:-1] == '\>')
        let l:old = l:old[2:-3]
    endif
    
    let l:old = escape(l:old, '/')

    let l:prmpt = printf('replace %s to ', l:old)
    let l:new =  input(l:prmpt)
    if empty(l:new)
        echohl WarningMsg
        echo '=> Warning : Specify a new word! rpl command was canceled'
        echohl None
        return
    endif
    let l:new = escape(l:new, '/')
    execute '%s/\V'.l:old.'/'.l:new.'/g'
endfunction


function! MyStatusLine()
    let l:md = mode()
    " Select highlight Scheme
    if (l:md == 'i')
        let l:mdcolor = '%#SCModeIns#'
    elseif (l:md == 'v' || l:md == 'V' || l:md == "\<C-v>")
        let l:mdcolor = '%#SCModeVis#'
    else
        let l:mdcolor = '%#SCModeNor#'
    endif
    " Display File Name
    let s = '%#SCPath# %F ('. &filetype . ') '
    " to right
    let s.= '%='
    " Display Present Mode
    let s.= l:mdcolor . '  ' . get(g:modename, l:md, l:md) . '  %*'
    " Display Host Name
    let s.= '%#SCHost# '. '['. matchstr(hostname(),'\w\+') .'] '
    " Display File Format
    let s.= '%#SCFile# [' . &fileencoding . ']'
    " Display Cursor Line
    let s.= '%#SCFile# [LINE:%l/%L]'
    " Display Cursor Column
    let s.= '%#SCFile# [COLUMN:%c]'
    return s
endfunction



let g:modename  = {'n': 'NORMAL'  , 'i': 'INSERT'  , 'v': 'VISUAL'  , 'V': 'V-LINE'  , "\<C-v>": 'V-BLOCK'  , 'R': 'REPLACE', 'c': 'COMMAND', 't': 'TERMINAL'}





