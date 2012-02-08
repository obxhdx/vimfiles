set lines=35        " Number of lines

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
" set guioptions-=r   " Remove right-hand scrollbar
set guioptions-=L   " Remove NERDTree scrollbar

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Inconsolata\ 15
endif

color molokai

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
