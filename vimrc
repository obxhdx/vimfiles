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

au BufRead,BufNewFile *.erb set ft=eruby.html
au BufRead,BufNewFile *.php set ft=php.html

" Highlight current line only on active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Better leader
let mapleader = ","
nmap \ ,

" Disable F1
map <F1> <nop>

" Better ESC
nmap ; :
vmap ; :
imap jk <ESC>

" Copy/Paste
map <C-c> "+y
imap <C-v> <ESC>"+gpi

" Scroll three lines instead of one
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Resize split windows
noremap + <C-w>+
noremap - <C-w>-
noremap ( <C-w><
noremap ) <C-w>>

" Change path to current file path
nnoremap <leader>cd :lcd %:p:h<CR>

" Expand %% to file path
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Use 'very magic' regex mode (help \v)
nnoremap / /\v
vnoremap / /\v

" Load plugins and stuff
source $HOME/.vim/functions.vim
source $HOME/.vim/plugins.vim

" Syntax highlighting
syntax on

if $TERM == 'xterm-256color'
  set t_Co=256
  set background=dark
  color badwolf

  hi markdownError ctermbg=NONE ctermfg=red
  hi Search ctermbg=45

  if has('unix')
    hi Normal ctermbg=NONE
    hi LineNr ctermbg=NONE
    hi NonText ctermbg=NONE
  end
end
