" General configurations
syntax on
set nu
set nowrap
set nocompatible
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set bs=2
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set lines=30
set columns=80 

" Color configurations
colorscheme monokai_imprvd
"set background=dark
set guifont=Ubuntu\ Mono\ 12 

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Copy and Paste by CTRL+C and CTRL+V
"nmap <C-V> "+gP
"imap <C-V> <ESC><C-V>i
"vmap <C-C> "+y 
