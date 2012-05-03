" General "{{{
set nocompatible " Be iMproved
set history=10000 " Remember more commands and search history
set undolevels=10000 " Use many levels of undo
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

so $VIMHOME/bundles.vim " Load vundle
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

if $TERM == 'xterm-256color'
  color railscasts
endif

" More friendly tab colors
highlight TabLine cterm=none ctermbg=235
highlight TabLineSel ctermbg=3 ctermfg=235
highlight TabLineFill ctermfg=233

" No ugly underlined current line
highlight CursorLine cterm=none ctermbg=234

" No ugly blue bg on tag matches
highlight MatchParen cterm=bold ctermbg=none ctermfg=221

" Bit better looking folded lines
highlight Folded cterm=bold ctermbg=none ctermfg=green

" Highlight long lines
highlight OverLength ctermbg=52 guibg=#592929
match OverLength /\%>80v.\+/
" "}}}

" Key mappings "{{{

" : modifier
nnoremap ; :
vnoremap ; :

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

" Change path to current file dir
nmap <leader>cd :lcd %:p:h<CR>

" Easy saving
inoremap <C-u> <ESC>:w<CR>

" Function keys
noremap <F1> <nop>
noremap <F2> :TagbarToggle<CR>
noremap <F4> :GundoToggle<CR>
set pastetoggle=<F6>
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

so $VIMHOME/functions.vim " Load custom funcions and commands
