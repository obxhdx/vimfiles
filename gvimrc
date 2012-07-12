set lines=33        " Number of lines
set columns=84      " Number of columns

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar"

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Inconsolata\ 13
endif

" let g:molokai_original = 1
" color molokai

" color railscasts
" hi MatchParen gui=bold guibg=#333435 guifg=yellow

color badwolf
hi lineNr guibg=#222222

" Do not hide mouse pointer when using NERDTree
set nomousehide
