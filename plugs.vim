if empty(glob('~/.vim/autoload/plug.vim'))
  echo "Vim-Plug is not installed...\nInstalling now..."
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLS --progress -o ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'

" Code Completion
Plug 'Raimondi/delimitMate', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh', 'on': [] }
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Code Lint
Plug 'sareyko/neat.vim'
Plug 'scrooloose/syntastic', { 'for': [ 'ruby', 'bash' ] }

" Color Schemes
Plug 'altercation/vim-colors-solarized'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'ronny/birds-of-paradise.vim'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'

" Git
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'tpope/vim-fugitive'

" Misc
Plug 'chrisbra/Recover.vim'
Plug 'junegunn/goyo.vim', { 'for': [ 'markdown' ] }
Plug 'junegunn/limelight.vim', { 'for': [ 'markdown' ] }

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl'
Plug 'terryma/vim-smooth-scroll'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-unimpaired'

" Syntax Utils
Plug 'dzeban/vim-log-syntax'
Plug 'gregsexton/MatchTag'
Plug 'kien/rainbow_parentheses.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/groovyindent'

" Text Objects
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': [ 'ruby' ] }

" Tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

call plug#end()

" On demand loading configuration

augroup InitCompletionPlugins
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe', 'delimitMate', 'vim-snippets')
        \| call youcompleteme#Enable() | autocmd! InitCompletionPlugins
augroup END

augroup InitGitPlugins
  autocmd!
  autocmd VimEnter * call LoadGitGutter() | autocmd! InitGitPlugins
augroup END

function! LoadGitGutter()
  if exists('*fugitive#head')
    call plug#load('vim-gitgutter')
  endif
endfunction

" Customizations start here...

" Commentary
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" FZF
" set rtp+=~/.fzf
map <Leader>z :FZF<CR>

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
autocmd FileType markdown nnoremap <Leader>g :Goyo<CR>

" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" NERDTree
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>

" Powerline
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = { 'BRANCH': '±' }
let g:Powerline_stl_path_style = 'filename'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Rainbow parentheses
augroup RainbowParentheses
  au!
  au BufEnter,FileType * RainbowParenthesesLoadRound
  au BufEnter,FileType * RainbowParenthesesLoadSquare
  au BufEnter,FileType * RainbowParenthesesLoadBraces
augroup END

" Smooth Scroll
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Startify
hi StartifyBracket ctermfg=240 guifg=#585858
hi StartifyFile    ctermfg=231 guifg=#ffffff
hi StartifyFooter  ctermfg=111 guifg=#87afff
hi StartifyHeader  ctermfg=203 guifg=#ff5f5f
hi StartifyNumber  ctermfg=215 guifg=#ffaf5f
hi StartifyPath    ctermfg=245 guifg=#8a8a8a
hi StartifySection ctermfg=111 guifg=#87afff
hi StartifySlash   ctermfg=240 guifg=#585858
hi StartifySpecial ctermfg=245 guifg=#8a8a8a

let g:startify_custom_header = [
      \ '                                 ________  __ __        ',
      \ '            __                  /\_____  \/\ \\ \       ',
      \ '    __  __ /\_\    ___ ___      \/___//''/''\ \ \\ \    ',
      \ '   /\ \/\ \\/\ \ /'' __` __`\        /'' /''  \ \ \\ \_ ',
      \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \      /'' /''__  \ \__ ,__\',
      \ '    \ \___/  \ \_\ \_\ \_\ \_\    /\_/ /\_\  \/_/\_\_/  ',
      \ '     \/__/    \/_/\/_/\/_/\/_/    \//  \/_/     \/_/    ',
      \ '',
      \ '',
      \ ]

let g:startify_custom_footer =
      \ ['', "   Vim is charityware. Please read ':help uganda'.", '']

let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

let g:startify_skiplist_server = [ 'GVIM' ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ $VIMRUNTIME .'/doc',
      \ '/usr/local/Cellar/vim/.*/doc',
      \ 'bundle/.*/doc',
      \ 'plugged/.*/doc',
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
