" General
set nocompatible " Be iMproved
set encoding=utf8 " Default encoding
set history=9999 " Remember more commands and search history
set undolevels=9999 " Use many levels of undo
set wildmode=longest:list " Command line tab completion option
set wildmenu
set backupdir=~/.vimbackup,/tmp " Group backup files in one place
set directory=~/.vimbackup,/tmp " Group swap files in one place
set tags+=gems.tags " Load gem tags when present
set mouse=a " Enable mouse
set splitbelow " Put splitted windows below the current one
set splitright " Put splitted windows right of the current one
set vb t_vb= " Disable visual bell

" Appearance
set number " Display line numbers
set laststatus=2 " Enable statusline
set cursorline " Highlight current line
set listchars=tab:».,trail:.,extends:❯,precedes:❮,nbsp:° " Unprintable chars
set list " Show unprintable chars
set showcmd " Show keystrokes on statusline
set title " Make xterm inherit the title from Vim

" Searching
set incsearch " Enable incremental search
set ignorecase " Ignore case sensitivity
set smartcase " Enable case-smart searching
set hlsearch " Highlight search matches

" Folding
set foldmethod=indent " Fold based on indent
set foldnestmax=10 " Max folding levels
set nofoldenable " Do not fold by default
set foldlevel=1

" Formatting
set expandtab " Insert space characters whenever the tab key is pressed
set tabstop=2 " Number of spaces for a tab
set shiftwidth=2 " Number of space characters inserted for indentation
set softtabstop=2 " Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set autoindent " Copy the indentation from the previous line, when starting a new line
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set nowrap " Disable line wrapping

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

" Better ESC
imap jk <ESC>

" Resize split windows
noremap + <C-w>+
noremap - <C-w>-
noremap ( <C-w><
noremap ) <C-w>>

" Use 'very magic' regex mode (help \v)
nnoremap / /\v
vnoremap / /\v

" Turn off match highlights
map <CR> :noh<CR>

" Find/replace
noremap <Leader>r :%s/\C<c-r>=expand("<cword>")<cr>/<c-r>=expand("<cword>")<cr>/gc<left><left><left>
noremap <Leader><Leader>r :%s/\C\<<c-r>=expand("<cword>")<cr>\>//gc<left><left><left>

" Select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Syntax highlighting
syntax on
set t_Co=256
set background=dark

" Load plugins and stuff
source $HOME/.vim/functions.vim
source $HOME/.vim/plugins.vim
source $HOME/.vim/abbreviations.vim
source $HOME/.vim/lightline.vim

" Some predefined coloring tweaks
au ColorScheme * call ColoringTweaks()
" Default theme
color badwolf

" Some small fixes by file type
augroup Highlight
  au!
  au BufRead,BufNewFile *.erb set ft=eruby.html
  au BufRead,BufNewFile *.php set ft=php.html
  au BufNewFile,BufRead *.gradle set ft=groovy
  au BufRead,BufNewFile *.md set commentstring=<!--%s-->
  au BufRead,BufNewFile *.groovy,*.gradle set commentstring=//%s
  au BufRead,BufNewFile *.groovy,*.gradley,*.gradle set tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" Highlight current line only on active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Rainbow parentheses
augroup RainbowParentheses
  au!
  au BufEnter,FileType * RainbowParenthesesLoadRound
  au BufEnter,FileType * RainbowParenthesesLoadSquare
  au BufEnter,FileType * RainbowParenthesesLoadBraces
augroup END
