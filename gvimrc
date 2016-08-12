set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar

set nomousehide     " Do not hide mouse pointer when using NERDTree
set vb t_vb=        " Disable visual bell

if has('mac')
  set guifont=Inconsolata\ for\ Powerline:h14
elseif has('unix')
  set guifont=Monospace\ 11
else
  set guifont=Consolas:h12
endif

if has('unix')
  au VimEnter,ColorScheme * call HighlightRemoveAttr('bold')
endif

colorscheme badwolf
