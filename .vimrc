"--- General settings

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"Display line numbers
set number

"Disable line wrapping
set nowrap

"Insert space characters whenever the tab key is pressed
set expandtab

"Number of spaces for a tab
set tabstop=2

"Number of space characters inserted for indentation
set shiftwidth=2

"Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set softtabstop=2

"Copy the indentation from the previous line, when starting a new line
set autoindent

"Allow backspacing over everything in insert mode
set bs=2 "same as set backspace=indent,eol,start

"Enable filetype detection
filetype on

"Enable filetype-specific indenting
filetype indent on

"Enable filetype-specific plugins
filetype plugin on

"Enable incremental search
set incsearch

"Highlight search matches
set hlsearch

"Make cmdline tab completion similar to bash
set wildmode=list:longest

"Enable CTRL-n and CTRL-p to scroll through matches
set wildmenu

"Ignored patterns when tab completing
set wildignore=*.o,*.obj,*~

"--- Code folding settings

"Fold based on indent
set foldmethod=indent

"Max folding levels
set foldnestmax=3

"Do not fold by default
set nofoldenable

"--- Color settings

"Makes colored text easier to read on dark backgrounds (use 'light' for light backgrounds)
"set background=dark

"Turn on syntax highlighting
syntax on

if has("gui_running")
  
  colorscheme monokai_imprvd
  set t_Co=256
  
  set lines=30
  set columns=80
  
  if has("gui_gnome")
    set guifont=Ubuntu\ Mono\ Bold\ 12
    "set guifont=Monospace\ Bold\ 10
  endif
  
  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
    set enc=utf-8
  endif
  
else
  
  if $COLORTERM == 'gnome-terminal'
    colorscheme monokai_imprvd
    "colorscheme railscasts
    set t_Co=256
    "set term=gnome-256color
  else
    colorscheme default
  endif
  
endif

"--- Key mappings

"CTRL+c and CTRL+v for Copying and Pasting
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

"CTRL+s for file saving
nmap <C-s> :w<CR>

"TAB and SHIFT+TAB for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"F9 for code folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"--- PHP settings

"Run file with PHP CLI (CTRL-m)
:autocmd FileType php noremap <C-M> :w!<CR>:!/opt/lampp/bin/php %<CR>

"PHP parser check (CTRL-l)
:autocmd FileType php noremap <C-L> :!/opt/lampp/bin/php -l %<CR>

"For above bindings, php bin dir must be in $PATH

"-- Easytags settings

"Make it recursively scan everything below the directory of the current file
:let g:easytags_autorecurse = 1
