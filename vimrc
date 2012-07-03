" Set $VIMHOME and load bundles "{{{
if has('unix')
  let $VIMHOME = $HOME."/.vim"
else
  let $VIMHOME = $VIM."/vimfiles"
endif

so $VIMHOME/bundles.vim " Load vundle
" "}}}

" General "{{{
set history=10000 " Remember more commands and search history
set undolevels=10000 " Use many levels of undo
set wildmode=list:longest,full " Command line tab completion option
set scrolloff=3 " Maintain more context around the cursor
set backupdir=~/.vimbackup,/tmp " Group backup files in one place
set directory=~/.vimbackup,/tmp " Group swap files in one place
set showcmd " Show keystrokes on statusline
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
set textwidth=80 " Fixed text width

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
set laststatus=2 " Enable statusline
set cursorline " Highlight current line
set list " Display unprintable chars
set listchars=tab:».,eol:¬,trail:.,extends:#,precedes:#,nbsp:° " Unprintable chars
set showbreak=... " Demark wrapped lines with ellipsis
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

if $TERM == 'xterm-256color'
  color neverland
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
" "}}}

" Key mappings "{{{
nnoremap ; :
vnoremap ; :
inoremap jk <ESC>

" C-c / C-v for copying and pasting
imap <C-v> jk"+gpi
map <C-c> "+y

" Change path to current file dir
nmap <leader>cd :lcd %:p:h<CR>

" Map F1 key to something useful
noremap <F1> <nop>
set pastetoggle=<F1>

noremap <leader>p :NERDTreeToggle<CR>
noremap <leader>t :TagbarToggle<CR>
noremap <leader>g :GundoToggle<CR>
" "}}}

so $VIMHOME/functions.vim " Load custom funcions and commands
