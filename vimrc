" General options " {{{
set history=10000 " Remember more commands and search history
set wildmenu " Enable command line completion menu
set backup " Enable file backup
set backupdir=~/.vim/tmp/backup// " Backup files dir
set directory=~/.vim/tmp/swap// " Swap files dir
set mouse=a " Enable mouse
set ttimeoutlen=10 " Disable Esc delay
set hidden " Hide buffers instead of closing them
set nrformats-=octal " Do not consider numbers starting with zero to be octal
set nojoinspaces " Use one space, not two, after punctuation
" }}}

" Appearance " {{{
set fillchars+=vert:│ " Custom vert split symbol
set number " Display line numbers
set laststatus=2 " Enable statusline
set statusline=%<\ %t\ %h%m%r%=%-14.(%l,%c%V%)\ %P\  " Standard statusline
set listchars=tab:».,trail:⌴,extends:❯,precedes:❮,nbsp:° " Unprintable chars
set showbreak=˾ " Line break character
set linebreak " Wrap long lines at a character in 'breakat'
set showcmd " Show keystrokes on statusline
syntax enable " Enable syntax highlighting

" Cursor shapes
let vertical_bar='CursorShape=1'
let underscore='CursorShape=2'
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;".vertical_bar."\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;".underscore."\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;".vertical_bar."\x7"
  let &t_EI = "\<Esc>]50;".underscore."\x7"
endif
" }}}

" Searching " {{{
set incsearch " Enable incremental search
set ignorecase " Ignore case sensitivity
set smartcase " Enable case-smart searching
set hlsearch " Highlight search matches
" }}}

" Folding " {{{
set foldmethod=indent " Fold based on indent
set nofoldenable " Do not fold by default
" }}}

" Formatting " {{{
set expandtab " Use spaces instead of tabs
set tabstop=2 " Number of spaces for each <Tab>
set shiftwidth=2 " Number of spaces used for indentation
set softtabstop=2 " Makes <BS> (backspace key) treat two spaces like a tab
set autoindent " When starting a new line, use same indentation level as the previous line
set backspace=indent,eol,start " Allow <BS> over everything in insert mode
set nowrap " Disable line wrapping
set formatoptions= " Clear options
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=c " Format comments
set formatoptions+=t " Wrap when using textwidth
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=j " Remove comment characters when joining lines
" }}}

" Key mappings " {{{

" Space as leader
let mapleader = " "

" Yank visual selection to clipboard
vnoremap <Leader>y "+y
" Yank with motion to clipboard
nnoremap <Leader>y "+y
" Yank line to clipboard
nnoremap <Leader>Y "+Y

" Paste clipboard contents on visual selection
vnoremap <Leader>p "+p
" Paste clipboard contents after cursor
nnoremap <Leader>p "+p
" Paste clipboard contents before cursor
nnoremap <Leader>P "+P

" Faster way to save/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>d :bd<CR>

" Change path to current file path
nnoremap cd :lcd %:p:h<CR>:pwd<CR>

" Expand %% to file path
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Find/replace
noremap <Leader>r :%s/\C\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
noremap <Leader><Leader>r :%s/\C<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" Select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Navigate buffers more easily
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" Automatically jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Pase in visual mode doesn't yank
xnoremap p pgvy

" }}}

" Auto cmds " {{{
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
" }}}

" Extra config files " {{{
source ~/.vim/functions.vim
source ~/.vim/plugins.vim

if filereadable(expand('~/.vimrc.local.vim'))
  source ~/.vimrc.local.vim
endif
" }}}

" vim: set foldmethod=marker foldenable :
