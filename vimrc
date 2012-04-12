" General "{{{
set nocompatible " Be iMproved
set history=1000 " Remember more commands and search history
set undolevels=1000 " Use many levels of undo
set wildmode=list:longest " Make cmdline tab completion similar to bash
set scrolloff=3 " Maintain more context around the cursor
set backupdir=~/.vimbackup,/tmp " Group backup files in one place
set directory=~/.vimbackup,/tmp " Group swap files in one place
" "}}}

" Searching "{{{
set incsearch " Enable incremental search
set ignorecase " Ignore case sensitivity
set smartcase " Enable case-smart searching
set hlsearch " Highlight search matches
" "}}}

" Formatting "{{{
set expandtab " Insert space characters whenever the tab key is pressed
set tabstop=2 " Number of spaces for a tab
set shiftwidth=2 " Number of space characters inserted for indentation
set softtabstop=2 " Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set autoindent " Copy the indentation from the previous line, when starting a new line
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set nowrap " Disable line wrapping

au BufWritePre *.css,*.html,*.js,*.php,*.rb,*.sql :%s/\s\+$//e " Remove trailing spaces before saving
au BufRead,BufNewFile *.eruby set ft=eruby.html
au BufRead,BufNewFile *.php set ft=php.html
au BufRead,BufNewFile *.md,*.mkd set ft=markdown
" "}}}

" Folding "{{{
set foldmethod=indent " Fold based on indent
set foldnestmax=10 " Max folding levels
set nofoldenable " Do not fold by default
set foldlevel=1
" "}}}

" Visual "{{{
set number " Display line numbers
set cursorline " Highlight current line
set list " Display unprintable chars
set listchars=tab:».,eol:¬,trail:.,extends:#,precedes:#,nbsp:° " Unprintable chars
" "}}}

" Set $VIMHOME and load bundles "{{{
if has('unix')
  let $VIMHOME = $HOME."/.vim"
else
  let $VIMHOME = $VIM."/vimfiles"
endif

so $VIMHOME/vimbundles.vim " Load vundle
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

if $TERM == 'xterm-256color'
  color railscasts
endif

highlight OverLength ctermbg=52 guibg=#592929
match OverLength /\%>80v.\+/ " Highlight long lines

highlight CursorLine cterm=none ctermbg=black " No ugly underline on terminal
" "}}}

" Key mappings "{{{

" : modifier
nnoremap ; :

" ESC modifiers
inoremap jj <ESC>
inoremap jk <ESC>
inoremap ;; <ESC>
inoremap <ESC> <nop>

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" C-c / C-v for copying and pasting
imap <C-v> ;;"+gpi
map <C-c> "+y

" C-Space for autocompleting
imap <C-Space> <C-x><C-o>

" Tab / S-Tab for indenting multiple lines
vmap <Tab> >gv
vmap <S-Tab> <gv

" A-k / A-j for moving lines around
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-j> :m'>+<CR>gv=gv

" Navigate through wrapped lines
vmap <Up> gk
vmap <Down> gj
nmap <Up> gk
nmap <Down> gj
vmap 0 g^
vmap $ g$
nmap 0 g^
nmap $ g$

" Change path to current file dir
nmap <leader>cd :lcd %:p:h<CR>

" Function keys
noremap <silent><F2> :TagbarToggle<CR>
noremap <silent><F3> :set hlsearch!<CR>
noremap <silent><F4> :GundoToggle<CR>
set pastetoggle=<F6>
noremap <silent><F7> :set spell!<CR>
noremap <silent><F8> :set wrap! linebreak! list! spell! spelllang=en,pt<CR> " Text editing mode
" "}}}

" Status line "{{{
if has("statusline")
  set laststatus=2

  " set statusline+=%<\                                 " truncation point
  " set statusline+=[%n]\                               " buffer number
  " set statusline+=%t\                                 " file name

  " set statusline+=[%{strlen(&ft)?&ft:'none'}\|        " filetype
  " set statusline+=%{strlen(&fenc)?&fenc:&enc}\|       " encoding
  " set statusline+=%{&fileformat}]\                    " file format

  " set statusline+=%#error#
  " set statusline+=%{&list?'['.nr2char(182).']':''}    " warns if list mode is enabled
  " set statusline+=%{&wrap?'[wrap]':''}                " warns wrap is enabled
  " set statusline+=%h%m%r%w                            " flags
  " set statusline+=%{StatuslineTrailingSpaceWarning()} " warns if there trailing spaces
  " set statusline+=%*

  " set statusline+=%=                                  " left/right separator
  " set statusline+=%(\ %{VisualSelectionSize()}%)\     " display selection count
  " set statusline+=%-14.(%l,%c%V%)                     " current line and column
  " set statusline+=\ %P                                " percent through file

  " hi StatusLine ctermfg=0 ctermbg=7 term=reverse gui=reverse
endif
" "}}}

" Dynamically sets wildignore list
let filename = '.wildignore'
if filereadable(filename)
  let igstring = ''
  for oline in readfile(filename)
    let line = substitute(oline, '\s|\n|\r', '', "g")
    if line =~ '^#' | con | endif
    if line == '' | con  | endif
    if line =~ '^!' | con  | endif
    if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
    let igstring .= "," . line
  endfor
  let execstring = "set wildignore=".substitute(igstring, '^,', '', "g")
  execute execstring
endif

so $VIMHOME/functions.vim " Load custom funcions
