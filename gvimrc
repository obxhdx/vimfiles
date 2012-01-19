" set lines=35        " Number of lines

set guioptions-=T   " Remove toolbar
set guioptions-=r   " Remove right-hand scrollbar
set guioptions-=L   " Remove NERDTree scrollbar

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Monofur\ 13
endif

function! AutoAssignColors()
  if (&ft == 'vim' || &ft == 'php' || &ft == 'php.html' || &ft == 'ruby')
    color molokai
  else
    color sexy-railscasts
  endif

  hi NonText guifg=#999999

  if has("statusline")
    hi StatusLine gui=reverse
  endif
endfunction

autocmd BufEnter,BufWritePost * :call AutoAssignColors()
