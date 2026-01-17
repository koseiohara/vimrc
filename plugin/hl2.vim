
" highlight the line and column where the cursor exist
" set cursorline
set cursorcolumn
" clear all highlight setting
highlight clear
" remove underline and set background color as 234 (see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
augroup InsertCursorLineUnderline
    autocmd!
    autocmd VimEnter    * highlight CursorLine cterm=NONE ctermbg=238 | set cursorline
    autocmd InsertEnter * set cursorline | highlight CursorLine   cterm=underline ctermbg=238
    autocmd InsertLeave * set cursorline | highlight CursorLine   cterm=NONE ctermbg=238
augroup END
" highlight CursorLine   cterm=NONE ctermbg=238
highlight CursorColumn cterm=NONE ctermbg=238
" Text Color
highlight Constant     cterm=NONE ctermfg=10
highlight Comment      cterm=NONE ctermfg=245
" Basic Obj Color
highlight Folded       cterm=NONE ctermfg=202 ctermbg=18
highlight Search       cterm=BOLD ctermfg=226 ctermbg=237
highlight LineNr                  ctermfg=247 ctermbg=235
highlight CursorLineNr            ctermfg=202 ctermbg=16
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


