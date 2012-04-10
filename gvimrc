set lines=35        " Number of lines
set columns=70      " Number of columns

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove NERDTree scrollbar

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Inconsolata\ 12
endif

" let g:molokai_original = 1
" color molokai
" color badwolf
" hi lineNr guibg=#222222
color railscasts

if has("statusline")
  hi StatusLine gui=reverse
endif

function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunction
au VimEnter,VimResized,BufWritePost * :call HandleScrollbars()
