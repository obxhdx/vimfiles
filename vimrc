" General options " {{{
set nocompatible " Be iMproved
set encoding=utf8 " Default encoding
set history=10000 " Remember more commands and search history
set wildmenu " Enable command line completion menu
set wildmode=longest:list " Command line completion mode
set backup " Enable file backup
set backupdir=~/.vim/tmp/backup// " Backup files dir
set directory=~/.vim/tmp/swap// " Swap files dir
set tags+=gems.tags " Load gem tags when present
set mouse=a " Enable mouse
set vb t_vb= " Disable visual bell
set timeoutlen=1000 " Leader key timeout (ms)
set ttimeoutlen=10 " Disable Esc delay
set hidden " Hide buffers instead of closing them
set updatetime=500
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

" Key mappings " {{{

" Space as leader
let mapleader = " "

" Yank/Paste from/to clipboard
vmap <Leader>y "+y
vmap <Leader>p "+p

" yank with motion
nmap <Leader>y "+y
" yank line
nmap <Leader>Y "+Y

" paste after cursor
nmap <Leader>p "+p
" paste before cursor
nmap <Leader>P "+P

" Faster way to save/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>

" Change path to current file path
nnoremap <Leader>cd :lcd %:p:h<CR>

" Expand %% to file path
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Disable annoying keys
map <F1> <nop>
imap <F1> <nop>
map K <nop>

" Resize split windows
noremap + <C-w>+
noremap - <C-w>-
noremap ( <C-w><
noremap ) <C-w>>

" Use 'very magic' regex mode (help \v)
nnoremap / /\v
vnoremap / /\v

" Find/replace
noremap <Leader>r :%s/\C<c-r>=expand("<cword>")<cr>/<c-r>=expand("<cword>")<cr>/gc<left><left><left>
noremap <Leader><Leader>r :%s/\C\<<c-r>=expand("<cword>")<cr>\>//gc<left><left><left>

" Select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Hit % with <Tab>
map <Tab> %

" Move faster with C-e/C-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" gt/gT moves to next/prev buffer/tab
nnoremap <silent>gt :exec tabpagenr('$') == 1 ? 'bn' : 'tabnext'<CR>
nnoremap <silent>gT :exec tabpagenr('$') == 1 ? 'bp' : 'tabprevious'<CR>
" }}}

" Syntax highlighting " {{{
syntax on
set t_Co=256
set background=dark
" }}}

" Autocommands " {{{

" Resize splits when the window is resized
au VimResized * :wincmd =

" Go to last line when opening a file
augroup LineReturn
  au!
  au BufWinEnter *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Highlight cursor line only for current buffer
augroup CursorLine
  au!
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

augroup FileTypeFixes
  au!
  au BufRead,BufNewFile *.gradle set ft=groovy
  au BufRead,BufNewFile *.erb set ft=eruby.html
  au BufRead,BufNewFile *.php set ft=php.html
  au BufRead,BufNewFile *.podspec set ft=ruby
  au FileType groovy set commentstring=//%s tabstop=4 shiftwidth=4 softtabstop=4
  au FileType markdown set commentstring=<!--%s-->
  au FileType tmux set commentstring=#%s
augroup END
" }}}

" Extra config files " {{{
source $HOME/.vim/functions.vim
source $HOME/.vim/plugins.vim
" }}}

" vim: set foldmethod=marker :
