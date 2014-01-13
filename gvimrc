set columns=75      " Number of columns
set lines=33        " Number of lines

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar

set nomousehide     " Do not hide mouse pointer when using NERDTree
set vb t_vb=        " Disable visual bell

if has('mac')
  set guifont=Monaco\ for\ Powerline:h12
elseif has('unix')
  set guifont=Ubuntu\ Mono\ for\ Powerline\ Bold\ 11
  au VimEnter,ColorScheme * call HighlightRemoveAttr('bold')
else
  set guifont=Consolas:h12
endif

color badwolf
hi markdownError guibg=NONE guifg=red
hi StartifyHeader  guifg=#ff5f5f
hi StartifyFooter  guifg=#87afff
hi StartifyBracket guifg=#585858
hi StartifyNumber  guifg=#ffaf5f
hi StartifyPath    guifg=#8a8a8a
hi StartifySlash   guifg=#585858
