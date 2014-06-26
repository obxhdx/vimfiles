filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Utilities
Plugin 'mhinz/vim-startify'
Plugin 'obxhdx/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'

" Editing helpers
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'gregsexton/MatchTag'
Plugin 'honza/vim-snippets'
Plugin 'kana/vim-textobj-user'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'

" Syntax files
Plugin 'sheerun/vim-polyglot'

" Colors
Plugin 'altercation/vim-colors-solarized'
Plugin 'ronny/birds-of-paradise.vim'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'

call vundle#end()
filetype plugin indent on

" Customizations start here...

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
