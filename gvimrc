" set lines=35        " Number of lines

set guioptions-=T   " Remove toolbar
set guioptions-=r   " Remove right-hand scrollbar
set guioptions-=L   " Remove NERDTree scrollbar

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Monofur\ 13
endif

if has("statusline")
  hi StatusLine gui=reverse
endif

function! AutoAssignColors()
  if (&ft == 'vim' || &ft == 'php' || &ft == 'ruby')
    color molokai
  else
    color bclear
  endif
endfunc

autocmd BufEnter,BufWritePost * :call AutoAssignColors()

hi NonText guifg=#999999
