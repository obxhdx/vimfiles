set columns=75      " Number of columns
set lines=33        " Number of lines

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar

set nomousehide     " Do not hide mouse pointer when using NERDTree

if has('mac')
  set guifont=Monaco\ for\ Powerline:h12
elseif has('unix')
  set guifont=Ubuntu\ Mono\ for\ Powerline\ Bold\ 11
else
  set guifont=Consolas:h12
endif

let g:default_dark_colors = 'molokai'

" Markdown underscore char fix
hi markdownError guifg=red ctermfg=red

autocmd VimEnter,ColorScheme * call HighlightRemoveAttr('bold')
