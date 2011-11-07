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

"Enable case-smart searching
set ignorecase
set smartcase

"Highlight search matches
set hlsearch

"Make cmdline tab completion similar to bash
set wildmode=list:longest

"Enable CTRL-n and CTRL-p to scroll through matches
set wildmenu

"Ignored patterns when tab completing
set wildignore=*.o,*.obj,*~

"Maintain more context around the cursor
set scrolloff=3

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
  
  set guioptions-=T "remove toolbar
  set guioptions-=r "remove right-hand scrollbar
  set guioptions-=L "remove NERDTree scrollbar
  
  if has("gui_gnome")
    set guifont=Ubuntu\ Mono\ 12
    "set guifont=Monospace\ 10
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

"F2 for toggling NERDTree
map <F2> :NERDTreeToggle<CR>

"F9 for code folding
nnoremap <F9> za
inoremap <F9> <C-O>za
vnoremap <F9> zf
onoremap <F9> <C-C>za

"CTRL+ALT+c and CTRL+ALT+v for copying and pasting
nmap <C-A-v> "+gP
imap <C-A-v> <ESC><C-V>i
vmap <C-A-c> "+y

"CTRL+d for deleting lines
nmap <C-d> dd
imap <C-d> <ESC>ddi
vmap <C-d> <S-V>d

"CTRL+v for Visual Mode also when in Insert Mode
imap <C-v> <ESC><C-v>

"CTRL+ALT+N for opening new tabs
nnoremap <C-A-n> :tabnew<CR>
inoremap <C-A-n> <ESC>:tabnew<CR>

"CTRL+Q for closing tabs
noremap <C-q> :tabclose<CR>

"ALT+UP / ALT+DOWN for moving lines around
nnoremap <A-Up> :m-2<CR>==
nnoremap <A-Down> :m+<CR>==
inoremap <A-Up> <ESC>:m-2<CR>==i
inoremap <A-Down> <ESC>:m+<CR>==i
vnoremap <A-Up> :m-2<CR>gv=gv
vnoremap <A-Down> :m'>+<CR>gv=gv

"CTRL+ALT+DOWN for duplicating lines
nnoremap <C-A-Down> yyp
inoremap <C-A-Down> <ESC>yypi
vnoremap <C-A-Down> <ESC>Yp

"CTRL+ALT+P for starting the Project view
noremap <C-A-p> :Project<CR>

"CTRL+SPACE for autocomplete
inoremap <C-Space> <C-x><C-o>

"Make CTRL+UP / CTRL+UP work like CTRL+e / CTRL+y
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>
inoremap <C-Up> <ESC><C-y>
inoremap <C-Down> <ESC><C-e>

"FuzzFinder key mappings
nmap <C-o> :FufFile **/<CR>
nmap <C-e> :FufBuffer<CR>

"-- Easytags settings

"Make it recursively scan everything below the directory of the current file
autocmd Filetype java,javascript,php,ruby let g:easytags_autorecurse = 1

"Always enable dynamic highlighting
let g:easytags_always_enabled = 1

"Use a python implementation of dynamic syntax highlighting script (2x faster than vim script)
let g:easytags_python_enabled = 1

"-- VIM-Project settings

let g:proj_flags="imstvcg"

"--- PHP settings

"Run file with PHP CLI (CTRL-m)
:autocmd FileType php noremap <C-M> :w!<CR>:!/opt/lampp/bin/php %<CR>

"PHP parser check (CTRL-l)
:autocmd FileType php noremap <C-L> :!/opt/lampp/bin/php -l %<CR>
