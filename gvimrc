" Syntax highlighting "{{{
syntax on " Turn it on
set t_Co=256 " Enable 256 colors
set background=dark " Background style
color molokai
" "}}}

" Font config "{{{
if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Monofur\ 13
endif
" "}}}
"
" Gui options "{{{
set guioptions-=T " Remove toolbar
set guioptions-=r " Remove right-hand scrollbar
set guioptions-=L " Remove NERDTree scrollbar
" "}}}
