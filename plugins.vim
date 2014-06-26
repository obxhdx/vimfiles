filetype off " Required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Utilities
Bundle 'gmarik/vundle'
Bundle 'mhinz/vim-startify'
Bundle 'obxhdx/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'

" Editing helpers
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'gregsexton/MatchTag'
Bundle 'honza/vim-snippets'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'tmhedberg/matchit'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'

" Syntax files
Bundle 'sheerun/vim-polyglot'

" Colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'ronny/birds-of-paradise.vim'
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'

filetype plugin indent on " Required

" FZF
set rtp+=~/.fzf
map <Leader>f :FZF<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" NERDTree
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" Rainbow parentheses
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

" Powerline
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = { 'BRANCH': '±' }
let g:Powerline_stl_path_style = 'filename'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Startify
let g:startify_skiplist_server = [ 'GVIM' ]
hi StartifyHeader  ctermfg=203 guifg=#ff5f5f
hi StartifyFooter  ctermfg=111 guifg=#87afff
hi StartifyBracket ctermfg=240 guifg=#585858
hi StartifyNumber  ctermfg=215 guifg=#ffaf5f
hi StartifyPath    ctermfg=245 guifg=#8a8a8a
hi StartifySlash   ctermfg=240 guifg=#585858
let g:startify_custom_header = [
      \ '   __      ___            ______ ____   ',
      \ '   \ \    / (_)           |____  |___ \ ',
      \ '    \ \  / / _ _ __ ___       / /  __) |',
      \ '     \ \/ / | | ''_ ` _ \     / /  |__ <',
      \ '      \  /  | | | | | | |   / /   ___) |',
      \ '       \/   |_|_| |_| |_|  /_(_) |____/ ',
      \ '',
      \ '',
      \ ]
