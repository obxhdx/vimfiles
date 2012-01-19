source ~/.vimbundles " Load Vundle first

" General "{{{
set nocompatible " Be iMproved
set history=100 " Remember more commands and search history
set undolevels=100 " Use many levels of undo
set wildmode=list:longest " Make cmdline tab completion similar to bash
set wildmenu " Enable CTRL-n and CTRL-p to scroll through matches
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
au BufWritePre *.html,*.php,*.rb,*.js,*.css,*.sql :%s/\s\+$//e " Remove all trailing spaces before saving a file
au BufRead,BufNewFile *.php set ft=php.html
au BufRead,BufNewFile *.md,*.mkd set ft=markdown
" "}}}

" Folding "{{{
set foldmethod=indent " Fold based on indent
set foldnestmax=3 " Max folding levels
set nofoldenable " Do not fold by default
" "}}}

" Visual "{{{
set number " Display line numbers
set cursorline " Highlight current line
set list " Display unprintable chars
set listchars=tab:».,eol:¬,trail:.,extends:#,precedes:#,nbsp:° " Unprintable chars
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

if $TERM == 'xterm-256color'
  color railscasts
else
  color default
endif
" "}}}

" Key mappings "{{{

" F keys
noremap <silent><F2> :NERDTreeToggle<CR>
noremap <silent><F3> :set hlsearch!<CR>
noremap <silent><F4> :GundoToggle<CR>
set pastetoggle=<F6>
noremap <silent><F7> :set spell!<CR>
noremap <silent><F8> :set wrap! linebreak! list! spell! spelllang=en,pt<CR> " Text editing mode
noremap <silent><F10> <ESC> :tab ball<CR> " Opens one tab for each open buffer

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

" Change path to current file dir
nmap <leader>cd :lcd %:p:h<CR>

" Reload config file
if has("gui_running")
  nmap <leader>rv :so ~/.gvimrc<CR>
else
  nmap <leader>rv :so ~/.vimrc<CR>
endif

" Markdown to HTML
au FileType markdown nmap <leader>md :%!markdown --html4tags <cr>

" Run file with PHP CLI (CTRL-m)
au FileType php noremap <C-M> :w!<CR>:!/opt/lampp/bin/php %<CR>

" PHP parser check (CTRL-l)
au FileType php noremap <C-L> :!/opt/lampp/bin/php -l %<CR>
" "}}}

" Status line "{{{
if has("statusline")
  set laststatus=2

  set statusline+=%<\                                 " truncation point
  set statusline+=[%n]\                               " buffer number
  set statusline+=%t\                                 " file name

  set statusline+=[%{strlen(&ft)?&ft:'none'}\|        " filetype
  set statusline+=%{strlen(&fenc)?&fenc:&enc}\|       " encoding
  set statusline+=%{&fileformat}]\                    " file format

  set statusline+=%#error#
  set statusline+=%{&list?'['.nr2char(182).']':''}    " warns if list mode is enabled
  set statusline+=%{&wrap?'[wrap]':''}                " warns wrap is enabled
  set statusline+=%h%m%r%w                            " flags
  set statusline+=%{StatuslineTrailingSpaceWarning()} " warns if there trailing spaces
  set statusline+=%*

  set statusline+=%=                                  " left/right separator
  set statusline+=%(\ %{VisualSelectionSize()}%)\     " display selection count
  set statusline+=%-14.(%l,%c%V%)                     " current line and column
  set statusline+=\ %P                                " percent through file

  hi StatusLine ctermfg=0 ctermbg=7 term=reverse
endif
" "}}}

" Return '[\s]' if trailing white space is detected
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunc

" Recalculate the trailing whitespace warning when idle, and after saving
au CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning

" Return number of chars|lines|blocks selected
function! VisualSelectionSize()
  if mode() == "v"
    " Exit and re-enter visual mode, because the marks
    " ('< and '>) have not been updated yet.
    exe "normal \<ESC>gv"
    if line("'<") != line("'>")
      return (line("'>") - line("'<") + 1) . ' lines'
    else
      return (col("'>") - col("'<") + 1) . ' chars'
    endif
  elseif mode() == "V"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . ' lines'
  elseif mode() == "\<C-V>"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
  else
    return ''
  endif
endfunc

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>sg :call <SID>SynStack()<CR>
