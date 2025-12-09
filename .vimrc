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
noremap <S-h> ^
noremap <S-l> $
noremap <S-k> gg
noremap <S-j> G
noremap <S-w> e
noremap <S-b> ge
nnoremap <Leader>b %
nnoremap x "_x
nnoremap s "_s
nnoremap ; :
nnoremap <Leader>q q:
noremap  q: <Nop>

" keymaps for folding
nnoremap <Leader><CR> za
" noremap <CR> zf
" noremap <BS> zd
" noremap <Leader>d zE
noremap <Leader>r zx
noremap z0 zM
noremap z1 zR

" keymaps for multi-tab
nnoremap <silent> <Tab>   :tabnext<CR>
nnoremap <silent> <S-Tab> :tabprevious<CR>
nnoremap <Leader>topen    :tabnew 

" keymaps for multi-window
nnoremap <silent> <C-l>   :wincmd l<CR>
nnoremap <silent> <C-h>   :wincmd h<CR>
nnoremap <silent> <C-k>   :wincmd k<CR>
nnoremap <silent> <C-j>   :wincmd j<CR>
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
set number
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


" highlight the line and column where the cursor exist
set cursorline
set cursorcolumn
" clear all highlight setting
highlight clear
" remove underline and set background color as 234 (see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
highlight CursorLine   cterm=NONE ctermbg=234
highlight CursorColumn cterm=NONE ctermbg=234
" Basic Obj Color
highlight Constant     cterm=NONE ctermfg=10
highlight Folded       cterm=NONE ctermfg=202 ctermbg=18
highlight Search       cterm=BOLD ctermfg=226 ctermbg=237
highlight LineNr                  ctermfg=254 ctermbg=235
highlight CursorLineNr            ctermfg=208 ctermbg=16
highlight FoldColumn              ctermfg=9   ctermbg=0
" Tab Line Color
highlight TabLine      cterm=NONE ctermfg=255 ctermbg=237
highlight TabLineSel   cterm=bold ctermfg=255 ctermbg=242
highlight TabLineFill             ctermfg=232 ctermbg=232
" Statusline Color Settings
highlight SCModeIns    cterm=bold ctermfg=0   ctermbg=47
highlight SCModeNor    cterm=bold ctermfg=0   ctermbg=117
highlight SCModeVis    cterm=bold ctermfg=0   ctermbg=200
highlight SCHost       cterm=bold ctermfg=255 ctermbg=237
highlight SCPath                  ctermfg=255 ctermbg=240
highlight SCFile       cterm=bold ctermfg=0   ctermbg=255

highlight VertSplit               ctermfg=245 ctermbg=245


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





