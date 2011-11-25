" Be iMproved
set nocompatible

" ### Vundle settings

filetype off "required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" ## My Bundles
" Github repos
Bundle 'gregsexton/gitv'
Bundle 'gregsexton/MatchTag'
Bundle 'msanders/snipmate.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'shawncplus/Vim-toCterm'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/gitignore'
Bundle 'vim-scripts/matchit.zip'
Bundle 'xolox/vim-easytags'
Bundle 'yurifury/hexHighlight'
" Non Github repos
Bundle 'git://git.wincent.com/command-t.git'

" ## My Colors
" Blueish colors
Bundle 'vim-scripts/dusk'
Bundle 'vim-scripts/oceandeep'
" Dark colors
Bundle 'eddsteel/vim-lanai'
Bundle 'oguzbilgic/sexy-railscasts-theme'
Bundle 'sickill/vim-monokai'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/molokai'
Bundle 'vim-scripts/Mustang2'
Bundle 'vim-scripts/paintbox'
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color'
Bundle 'vim-scripts/Sift'
Bundle 'vim-scripts/Tango2'
Bundle 'vim-scripts/The-Vim-Gardener'
Bundle 'vim-scripts/twilight'
Bundle 'vim-scripts/Wombat'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'vim-scripts/Zenburn'
" Light colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'ChrisKempson/Vim-Tomorrow-Theme'
Bundle 'gregsexton/Gravity'
Bundle 'nelstrom/vim-mac-classic-theme'
Bundle 'obxhdx/vim-github-theme'
Bundle 'vim-scripts/bclear'
Bundle 'vim-scripts/tango-morning.vim'

filetype plugin indent on "required

" ### General settings

" Display line numbers
set number

" Display current position along the bottom
set ruler

" Display selection count on the statusline
set showcmd

" Disable line wrapping
set nowrap

" Insert space characters whenever the tab key is pressed
set expandtab

" Number of spaces for a tab
set tabstop=2

" Number of space characters inserted for indentation
set shiftwidth=2

" Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set softtabstop=2

" Copy the indentation from the previous line, when starting a new line
set autoindent

" Allow backspacing over everything in insert mode
set bs=2 " same as set backspace=indent,eol,start

" Enable incremental search
set incsearch

" Enable case-smart searching
set ignorecase
set smartcase

" Highlight search matches
set hlsearch

" Remember more commands and search history
set history=100

" Use many levels of undo
set undolevels=100

" Make cmdline tab completion similar to bash
set wildmode=list:longest

" Enable CTRL-n and CTRL-p to scroll through matches
set wildmenu

" Ignored patterns when tab completing
set wildignore=*.o,*.obj,*~,*.mp3,*.jpg,*.png,*.gif,*.avi

" Maintain more context around the cursor
set scrolloff=3

" Display white spaces
set list
set listchars=tab:‣.,eol:¬,trail:.,extends:#,precedes:#,nbsp:.

" Group backup and swap files in one place
set backupdir=~/.vimbackup,/tmp
set directory=~/.vimbackup,/tmp

" Change the current dir to the same of the current file
autocmd BufEnter * silent! lcd %:p:h

" Automatically remove all trailing spaces before saving file
autocmd BufWritePre *.html,*.php,*.rb,*.js,*.css :%s/\s\+$//e

" ### Code folding settings

" Fold based on indent
set foldmethod=indent

" Max folding levels
set foldnestmax=3

" Do not fold by default
set nofoldenable

" ### Appearance settings

" Set window size
set lines=30
set columns=80

" Set background type
set background=dark "or light

" Turn on syntax highlighting
syntax on

let $my_theme = "molokai" 
let $my_term_theme = "railscasts" 

if has("gui_running" )

  set t_Co=256
  colorscheme $my_theme

  set guioptions-=T "remove toolbar
  set guioptions-=r "remove right-hand scrollbar
  set guioptions-=L "remove NERDTree scrollbar

  if has("gui_gnome" )
    set guifont=Monofur\ 13
  endif

  if has("gui_win32" ) || has("gui_win32s" )
    set guifont=Consolas:h12
    set enc=utf-8
  endif

else

  if $COLORTERM == 'gnome-terminal'
    " let g:solarized_termcolors=256
    set t_Co=256
    colorscheme $my_term_theme
  else
    colorscheme default
  endif

endif

" Invisible character colors
hi NonText guifg=#4a4a59
hi SpecialKey guifg=#4a4a59

" ### Key mappings

" Tab and SHIFT-Tab for indenting while on insert mode
imap <Tab> <ESC>>>i
imap <S-Tab> <ESC><<i

" Tab and SHIFT-Tab for indenting multiple lines
vmap <Tab> >gv
vmap <S-Tab> <gv

" CTRL+v for Visual Mode also when in Insert Mode
imap <C-v> <ESC><C-v>

" CTRL+Space for autocomplete
inoremap <C-Space> <C-x><C-o>

" Make CTRL+Up / CTRL+Up work like CTRL+e / CTRL+y
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>
inoremap <C-Up> <ESC><C-y>
inoremap <C-Down> <ESC><C-e>

" CTRL+ALT+c and CTRL+ALT+v for copying and pasting
imap <C-A-v> <ESC>"+gPi
map <C-c> "+y

" CTRL+ALT+Up/Down for duplicating lines
vnoremap <C-A-Up> y']P==
vnoremap <C-A-Down> y']p==
inoremap <C-A-Up> <ESC>YP==i
inoremap <C-A-Down> <ESC>Yp==i

" ALT+Up / ALT+Down for moving lines around
inoremap <A-Up> <ESC>:m-2<CR>==i
inoremap <A-Down> <ESC>:m+<CR>==i
vnoremap <A-Up> :m-2<CR>gv=gv
vnoremap <A-Down> :m'>+<CR>gv=gv

" Navigate through wrapped lines
vmap <Up> gk
vmap <Down> gj
vmap 0 g^
vmap $ g$
nmap <Up> gk
nmap <Down> gj
nmap 0 g^
nmap $ g$

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

" ### Function keys

" F2 for toggling NERDTree
noremap <F2> :NERDTreeToggle<CR>

" F3 for toggling highlighted search matches
noremap <F3> :set hlsearch!<CR>

" F4 for toggling Gundo tree
noremap <F4> :GundoToggle<CR>

" F5 for toggling indenting guides
noremap <F5> :IndentGuidesToggle<CR>

" F6 for 'paste mode' toggling
set pastetoggle=<F6>

" F7 for toggling spell checking
noremap <silent> <F7> :set spell!<CR>

" F8 for toggling text editing mode
noremap <silent> <F8> :set wrap! linebreak! list!<CR>

" F9 for code folding
nnoremap <F9> za
inoremap <F9> <C-O>za
vnoremap <F9> zf
onoremap <F9> <C-C>za

"F10 for toggling background (dark/light)
call togglebg#map("<F10>") "requires solarized togglebg plugin

" ### Easytags settings

" Make it recursively scan everything below the directory of the current file
autocmd Filetype java,javascript,php,ruby let g:easytags_autorecurse = 1

" Always enable dynamic highlighting
let g:easytags_always_enabled = 1

" Use a python implementation of dynamic syntax highlighting script (2x faster than vim script)
let g:easytags_python_enabled = 1

" Store tags by filetype
let g:easytags_by_filetype = '~/.vimtags'

" ### CommandT settings

" Never show dot files
let g:CommandTNeverShowDotFiles = 1

"### Indent Guides settings

" Guide line size
let g:indent_guides_guide_size = 1

" ### PHP settings

" Run file with PHP CLI (CTRL-m)
autocmd FileType php noremap <C-M> :w!<CR>:!/opt/lampp/bin/php %<CR>

" PHP parser check (CTRL-l)
autocmd FileType php noremap <C-L> :!/opt/lampp/bin/php -l %<CR>

" Markdown settings

" Markdown to HTML
nmap <leader>md :%!markdown --html4tags <cr>

" ### Custom functions

" Show syntax highlighting groups for word under cursor
nmap <leader>sg :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack" )
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name" )')
endfunc
