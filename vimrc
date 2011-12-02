source .vimbundles " Load Vundle first

" General "{{{
set nocompatible " Be iMproved
set history=100 " Remember more commands and search history
set undolevels=100 " Use many levels of undo
set wildmode=list:longest " Make cmdline tab completion similar to bash
set wildmenu " Enable CTRL-n and CTRL-p to scroll through matches
set scrolloff=3 " Maintain more context around the cursor
set clipboard+=unnamed " Yanks go to clipboard
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
au BufWritePre *.html,*.php,*.rb,*.js,*.css,*.sql :%s/\s\+$//e " Remove all trailing spaces before saving a file
au BufRead,BufNewFile *.php set ft=php.html
" "}}}

" Folding "{{{
set foldmethod=indent " Fold based on indent
set foldnestmax=3 " Max folding levels
set nofoldenable " Do not fold by default
" "}}}

" Visual "{{{
set number " Display line numbers
set ruler " Display current position along the bottom
set showcmd " Display selection count on the statusline
set list " Display unprintable chars
set listchars=tab:‣.,eol:¬,trail:.,extends:#,precedes:#,nbsp:. " Unprintable chars
set lines=35 " Window size
set columns=80 " Window size

if has("gui_running")
  set guioptions-=T " Remove toolbar
  set guioptions-=r " Remove right-hand scrollbar
  set guioptions-=L " Remove NERDTree scrollbar
endif
" "}}}

" Font config "{{{
if has("gui_running")
  if has("gui_gnome")
    set guifont=Monofur\ 13
  endif
  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
  endif
endif
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on
set t_Co=256 " Enable 256 colors
set background=dark " Background style

if has("gui_running")
  colorscheme molokai
else
  if $COLORTERM == 'gnome-terminal'
    colorscheme railscasts
  else
    colorscheme default
  endif
endif
" "}}}

" Custom functions "{{{
" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>sg :call <SID>SynStack()<CR>
" "}}}

" F keys "{{{
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :set hlsearch!<CR>
noremap <F4> :GundoToggle<CR>
noremap <F5> :IndentGuidesToggle<CR>
set pastetoggle=<F6>
noremap <F7> :set spell!<CR>
noremap <F8> :set wrap! linebreak! list! spell! spelllang=en,pt<CR> " Text editing mode
" nnoremap <F9> za " F9 for code folding
" inoremap <F9> <C-O>za
" vnoremap <F9> zf
" onoremap <F9> <C-C>za
noremap <F10> <ESC> :tab ball<CR> " Opens one tab for each open buffer
" "}}}

" Key mappings "{{{
" Tab and SHIFT-Tab for indenting while on insert mode
imap <Tab> <ESC>>>i
imap <S-Tab> <ESC><<i
" Tab and SHIFT-Tab for indenting multiple lines
vmap <Tab> >gv
vmap <S-Tab> <gv
" CTRL+Space for autocompleting
imap <C-Space> <C-x><C-o>
" CTRL+ALT+c and CTRL+ALT+v for copying and pasting
imap <C-A-v> <ESC>"+gPi
map <C-c> "+y
" Make CTRL+Up / CTRL+Up work like CTRL+e / CTRL+y
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>
inoremap <C-Up> <ESC><C-y>
inoremap <C-Down> <ESC><C-e>
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
" Quickly edit the vimrc file
nmap <leader>ev :e $MYVIMRC<CR>
" Quickly reload the vimrc file
nmap <leader>rv :so $MYVIMRC<CR>
" Change pwd to current buffer path
nmap <leader>cp :lcd %:p:h<CR>
" Markdown to HTML
au FileType markdown nmap <leader>md :%!markdown --html4tags <cr>
" Run file with PHP CLI (CTRL-m)
au FileType php noremap <C-M> :w!<CR>:!/opt/lampp/bin/php %<CR>
" PHP parser check (CTRL-l)
au FileType php noremap <C-L> :!/opt/lampp/bin/php -l %<CR>
" "}}}
