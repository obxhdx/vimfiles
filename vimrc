" General options " {{{
set nocompatible " Be iMproved
set encoding=utf8 " Default encoding
set history=10000 " Remember more commands and search history
set wildmenu " Enable command line completion menu
set wildmode=longest:full,full " Command line completion mode
set backup " Enable file backup
set backupdir=~/.vim/tmp/backup// " Backup files dir
set directory=~/.vim/tmp/swap// " Swap files dir
set tags+=~/.vim/tags/ruby_gems " Load gem tags when present
set mouse=a " Enable mouse
set vb t_vb= " Disable visual bell
set timeoutlen=1000 " Leader key timeout (ms)
set ttimeoutlen=10 " Disable Esc delay
set hidden " Hide buffers instead of closing them
set updatetime=500
set nrformats-=octal " Do not consider numbers starting with zero to be octal
" }}}

" Appearance " {{{
set number " Display line numbers
set laststatus=2 " Enable statusline
set cursorline " Highlight current line
set list " Show unprintable chars
set listchars=tab:».,trail:⌴,extends:❯,precedes:❮,nbsp:° " Unprintable chars
set showbreak=… " Line break character
set showcmd " Show keystrokes on statusline
set title " Make xterm inherit the title from Vim
let &t_SI = "\<Esc>[5 q" " Use a blinking upright bar cursor in Insert mode
let &t_EI = "\<Esc>[1 q" " Use a blinking block in Normal
" }}}

" Auto-complete (^N and ^P) {{{
set complete=   " Clear options
set complete+=. " Scan the current buffer
set complete+=w " Scan buffers from other windows
set complete+=b " Scan other loaded buffers that are in the buffer list
set complete+=u " Scan unloaded buffers that are in the buffer list
set complete+=U " Scan buffers that are not in the buffer list
set complete+=i " Scan current and included files
set complete+=] " Tag completion
"}}}

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

" File explorer "{{{
let g:netrw_banner=0 " No banner
let g:netrw_liststyle=3 " Tree style listing
let g:netrw_preview=1 " Open previews vertically
let g:netrw_altv=1 " Open files on right
"}}}

" Key mappings " {{{

" Space as leader
let mapleader = " "
let maplocalleader = "\\"

" Yank visual selection to clipboard
vmap <Leader>y "+y
" Yank with motion to clipboard
nmap <Leader>y "+y
" Yank line to clipboard
nmap <Leader>Y "+Y

" Paste clipboard contents on visual selection
vmap <Leader>p "+p
" Paste clipboard contents after cursor
nmap <Leader>p "+p
" Paste clipboard contents before cursor
nmap <Leader>P "+P

" Faster way to save/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
autocmd BufRead,BufEnter * if expand('%:t') !~? 'NERD' | execute 'nnoremap <buffer> <Leader>d :bd<CR>' | endif

" Change path to current file path
nnoremap <Leader>cd :lcd %:p:h<CR>

" Expand %% to file path
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Disable annoying keys
map <F1> <nop>
imap <F1> <nop>
map K <nop>

" Resize split windows
nnoremap + :exe 'resize ' . (winheight(0) * 3/2)<CR>
nnoremap - :exe 'resize ' . (winheight(0) * 2/3)<CR>
nnoremap ) :exe 'vertical resize ' . (winwidth(0) * 3/2)<CR>
nnoremap ( :exe 'vertical resize ' . (winwidth(0) * 2/3)<CR>

" Use 'very magic' regex mode (help \v)
nnoremap / /\v
vnoremap / /\v

" Find/replace
noremap <Leader>r :%s/\C\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
noremap <Leader><Leader>r :%s/\C<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" Select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Move faster with C-e/C-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Navigate buffers more easily
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" Automatically jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Add ; more easily
autocmd BufRead,BufNewFile *.js inoremap <buffer> ;; <ESC>A;<ESC>

" Open stuff (URL, etc)
if has('mac')
  nnoremap <Leader>o :exe 'silent !open '.shellescape(expand('<cWORD>'), 1)<CR>:exe 'redraw!'<CR>
endif

" }}}

" Syntax highlighting " {{{
syntax on
set t_Co=256
set background=dark
" }}}

" Autocommands " {{{

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

autocmd FilterWritePre * if &diff
      \|   setlocal nocursorline | exe 'DisableAutoHighlightWord'
      \| else
      \|   setlocal cursorline | exe 'EnableAutoHighlightWord'
      \| endif

augroup FileTypeFixes
  autocmd!
  autocmd BufRead,BufNewFile *.gradle  setf groovy
  autocmd BufRead,BufNewFile *.podspec setf ruby

  autocmd FileType groovy     setlocal tabstop=4 shiftwidth=4 softtabstop=4 commentstring=//%s
  autocmd FileType java       setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 completeopt-=preview
  autocmd FileType json       setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType markdown   setlocal commentstring=<!--%s--> spell
  autocmd FileType qf         setlocal nonu
  autocmd FileType tmux       setlocal commentstring=#%s
  autocmd FileType gitcommit  setlocal spell
augroup END
" }}}

" Extra config files " {{{
source $HOME/.vim/functions.vim
source $HOME/.vim/plugins.vim
" }}}

" vim: set foldmethod=marker :
