filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Appearance
Plugin 'kshenoy/vim-signature'
Plugin 'itchyny/lightline.vim'

" Code Completion
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

" Code Lint
Plugin 'sareyko/neat.vim'
Plugin 'scrooloose/syntastic'

" Color Schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'ronny/birds-of-paradise.vim'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'

" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Misc
Plugin 'chrisbra/Recover.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" Navigation
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'tpope/vim-unimpaired'

" Syntax Utils
Plugin 'gregsexton/MatchTag'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-scripts/groovyindent'

" Text Objects
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

" Tools
Plugin 'gmarik/Vundle.vim'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

" Customizations start here...

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" FZF
set rtp+=~/.fzf
map <Leader>f :FZF<CR>

" GitGutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Goyo
fun! GoyoBefore()
  if exists('$TMUX')
    silent !tmux set status off
  endif
  call TextEditorMode()
  Limelight
endf

fun! GoyoAfter()
  if exists('$TMUX')
    silent !tmux set status on
  endif
  call TextEditorMode()
  Limelight!
endf

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
nnoremap <Leader>g :Goyo<CR>

" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" NERDTree
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" Powerline
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = { 'BRANCH': '±' }
let g:Powerline_stl_path_style = 'filename'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Smooth Scroll
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Startify
hi StartifyHeader  ctermfg=203 guifg=#ff5f5f
hi StartifyFooter  ctermfg=111 guifg=#87afff
hi StartifyBracket ctermfg=240 guifg=#585858
hi StartifyNumber  ctermfg=215 guifg=#ffaf5f
hi StartifyPath    ctermfg=245 guifg=#8a8a8a
hi StartifySlash   ctermfg=240 guifg=#585858
let g:startify_skiplist_server = [ 'GVIM' ]
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
let g:startify_skiplist = [
        \ $VIMRUNTIME .'/doc',
        \ '/usr/local/Cellar/vim/.*/doc',
        \ 'bundle/.*/doc',
        \ ]

" Syntastic
let g:syntastic_ruby_checkers = [ 'rubocop' ]
let g:syntastic_sh_checkers = [ 'shellcheck' ]
let g:syntastic_zsh_checkers = [ 'zsh' ]
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5

" UltiSnips
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
