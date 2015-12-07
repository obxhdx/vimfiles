if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations "{{{

call plug#begin('~/.vim/bundle')

" Appearance"{{{
Plug 'ap/vim-buftabline'
Plug 'edkolev/tmuxline.vim', { 'on': 'Tmuxline' }
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-webdevicons'
" }}}

" Code Completion"{{{
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh', 'on': [] }
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" }}}

" Code Lint"{{{
Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'css' ] }
Plug 'sareyko/neat.vim', { 'on': 'Neat' }
Plug 'scrooloose/syntastic', { 'on': [ 'SyntasticCheck', 'SyntasticToggleMode' ] }
" }}}

" Color Schemes"{{{
Plug 'chriskempson/base16-vim'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'sjl/badwolf'
Plug 'zeis/vim-kolor'
" }}}

" Git"{{{
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'tpope/vim-fugitive'
" }}}

" Misc"{{{
Plug 'EinfachToll/DidYouMean'
Plug 'chrisbra/Recover.vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'junegunn/limelight.vim'
Plug 'kopischke/vim-stay'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-rsi'
" }}}

" Navigation"{{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl' " Dependency for vim-oblique
Plug 'kopischke/vim-fetch'
Plug 'terryma/vim-smooth-scroll'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-unimpaired'
" }}}

" Syntax Utils"{{{
Plug 'dzeban/vim-log-syntax'
Plug 'gregsexton/MatchTag'
Plug 'jelera/vim-javascript-syntax'
Plug 'kien/rainbow_parentheses.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/groovyindent'
" }}}

" Text Objects"{{{
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': [ 'ruby' ] }
" }}}

" Tools"{{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install', 'on': 'FZF' }
Plug 'mhinz/vim-startify'
Plug 'obxhdx/slimux', { 'branch': 'pane-list', 'on': [ 'SlimuxREPLSendSelection' ] }
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
" }}}

call plug#end()

" }}}

" On-demand Loading"{{{
augroup LoadCompletionPlugins
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe', 'delimitMate', 'vim-snippets')
        \| call youcompleteme#Enable()
        \| autocmd! LoadCompletionPlugins
augroup END

augroup LoadGitGutter
  autocmd!
  autocmd BufWritePost * if !empty(fugitive#head()) && get(g:, 'gitgutter_enabled') == 0
        \| call plug#load('vim-gitgutter')
        \| execute 'GitGutterEnable'
        \| execute 'autocmd! LoadGitGutter'
        \| endif
augroup END
" }}}

" Plugin Customizations"{{{

" Colorscheme {{{
try
  set term=screen-256color
  set t_Co=256
  set background=dark
  let base16colorspace=256
  colorscheme iceberg
catch
endtry
" }}}

" BufTabline"{{{
let g:buftabline_show = 1
let g:buftabline_indicators = 1
hi BufTabLineCurrent ctermbg=203 ctermfg=232
hi BufTabLineActive ctermbg=236 ctermfg=203
hi BufTabLineHidden ctermbg=236
hi BufTabLineFill ctermbg=236
" }}}

" Commentary"{{{
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" }}}

" delimitMate"{{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}

" FZF"{{{
nnoremap <Leader>z :FZF<CR>
" }}}

" GitGutter"{{{
let g:gitgutter_eager = 0
let g:gitgutter_map_keys = 0
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
" }}}

" JsBeautify "{{{
augroup JsBeautify
  autocmd!
  autocmd FileType javascript noremap <buffer> <Leader>= :call JsBeautify()<CR>
  autocmd FileType html noremap <buffer> <Leader>= :call HtmlBeautify()<CR>
  autocmd FileType css noremap <buffer> <Leader>= :call CSSBeautify()<CR>
augroup END
"}}}

" Limelight"{{{
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" }}}

" Lightline"{{{
try
source $HOME/.vim/lightline.vim
catch
endtry
"}}}

" Markdown"{{{
let g:markdown_folding = 1
"}}}

" NERDTree"{{{
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeWinSize = 40
let NERDTreeMinimalUI = 1
let NERDTreeCascadeOpenSingleChildDir = 1
let NERDTreeShowHidden = 1
autocmd FileType nerdtree nnoremap <silent> <buffer> <C-j> :call nerdtree#ui_glue#invokeKeyMap(g:NERDTreeMapActivateNode)<CR>

map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

hi NERDTreeCWD       ctermfg=2    ctermbg=NONE  cterm=NONE
hi NERDTreeDir       ctermfg=240  ctermbg=NONE  cterm=NONE
hi NERDTreeFile      ctermfg=246  ctermbg=NONE  cterm=NONE
hi NERDTreeOpenable  ctermfg=3    ctermbg=NONE  cterm=NONE
hi NERDTreeClosable  ctermfg=2    ctermbg=NONE  cterm=NONE
hi link NERDTreeDirSlash NERDTreeDir

function! NERDTreeHighlightFile(extension, fg, bg, mod)
  exec 'autocmd filetype nerdtree syn match ' . a:extension . ' #^\s\+.*' . a:extension . '\*\?$#'
  exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermbg=' . a:bg . ' ctermfg=' . a:fg . ' cterm=' . a:mod
endfunction

function! NERDTreeMapFileNameToExt(filename, extension)
  exec 'autocmd filetype nerdtree syn match ' . a:extension . ' #^\s\+.*' . a:filename . '\*\?$#'
endfunction

call NERDTreeHighlightFile('css',         '13',   'NONE',  'NONE')
call NERDTreeHighlightFile('feature',     '41',   'NONE',  'NONE')
call NERDTreeHighlightFile('gradle',      '222',  'NONE',  'NONE')
call NERDTreeHighlightFile('groovy',      '131',  'NONE',  'NONE')
call NERDTreeHighlightFile('html',        '215',  'NONE',  'NONE')
call NERDTreeHighlightFile('java',        '132',  'NONE',  'NONE')
call NERDTreeHighlightFile('js',          '162',  'NONE',  'NONE')
call NERDTreeHighlightFile('json',        '191',  'NONE',  'NONE')
call NERDTreeHighlightFile('md',          '184',  'NONE',  'NONE')
call NERDTreeHighlightFile('properties',  '229',  'NONE',  'NONE')
call NERDTreeHighlightFile('rb',          '197',  'NONE',  'NONE')
call NERDTreeHighlightFile('sh',          '208',  'NONE',  'NONE')
call NERDTreeHighlightFile('vim',         '255',  'NONE',  'NONE')
call NERDTreeHighlightFile('xml',         '210',  'NONE',  'NONE')
call NERDTreeHighlightFile('yaml',        '229',  'NONE',  'NONE')
call NERDTreeHighlightFile('yml',         '229',  'NONE',  'NONE')

call NERDTreeMapFileNameToExt('Rakefile', 'rb')
" }}}

" Oblique {{{
autocmd! User ObliqueStar normal n
autocmd VimEnter * noremap gd gd:normal n<CR>:normal N<CR>
autocmd VimEnter * noremap gD gD:normal n<CR>:normal N<CR>
let g:oblique#incsearch_highlight_all = 1
"}}}

" Powerline"{{{
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = { 'BRANCH': '±' }
let g:Powerline_stl_path_style = 'filename'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" }}}

" Rainbow parentheses"{{{
augroup Rainbows
  autocmd!
  autocmd Syntax groovy,java silent! RainbowParenthesesActivate
  autocmd Syntax groovy,java silent! RainbowParenthesesLoadRound
  autocmd Syntax groovy,java silent! RainbowParenthesesLoadSquare
  autocmd Syntax groovy,java silent! RainbowParenthesesLoadBraces
augroup END
" }}}

" Rsi"{{{
augroup DisableRsiMappings
  autocmd!
  autocmd VimEnter * iunmap <C-A>
  autocmd VimEnter * iunmap <C-X><C-A>
  autocmd VimEnter * iunmap <C-B>
  autocmd VimEnter * iunmap <C-D>
  autocmd VimEnter * iunmap <C-E>
  autocmd VimEnter * iunmap <C-F>
augroup END
"}}}

" Smooth Scroll"{{{
augroup SmoothScroll
  autocmd!
  autocmd VimEnter * if &ft !=? 'todo'
        \| execute 'nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 15, 4)<CR>'
        \| execute 'nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 15, 4)<CR>'
        \| execute 'nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 15, 4)<CR>'
        \| execute 'nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 15, 4)<CR>'
        \| endif
augroup END
" }}}

" Slimux"{{{
let g:slimux_select_from_current_window = 1
let g:slimux_pane_format = '[#{session_name}] #{window_index}.#{pane_index} [#{window_name}] #{pane_title}'

au FileType slimux syntax match slimuxPaneId /\v^\%[0-9]+\ze:/
au FileType slimux syntax match slimuxPaneIndex /\v[0-9]+\.[0-9]+/
au FileType slimux syntax match slimuxSessionOrWindowName /\v\s\[[[:alnum:]]+\]\s/

hi def link slimuxPaneId WarningMsg
hi def link slimuxPaneIndex Constant
hi def link slimuxSessionOrWindowName Title
"}}}

" Splitjoin {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>
"}}}

" Startify"{{{
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
" }}}

" Syntastic"{{{
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
      \ }
let g:syntastic_javascript_checkers = [ 'jslint' ]
let g:syntastic_javascript_jslint_args = '--browser --devel --node --nomen --this --white'
let g:syntastic_ruby_checkers = [ 'rubocop' ]
let g:syntastic_sh_checkers = [ 'shellcheck' ]
let g:syntastic_zsh_checkers = [ 'zsh' ]
nnoremap gs :SyntasticToggleMode<CR>
" }}}

" Tern.js"{{{
augroup DisplayTernType
  autocmd!
  autocmd VimEnter * autocmd FileType javascript call DisplayTernType()
  autocmd FileType javascript autocmd CursorHold <buffer> call DisplayTernType()
augroup END

function! DisplayTernType()
  let l:current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
  let l:current_word = expand('<cword>')

  if l:current_char =~ '\v\s|\=|\&|\(|\)|\[\]\{|\}'
    return ''
  endif

  if l:current_word =~# '\v<(var|function|return|if|for|in|while)>'
    return ''
  endif

  if l:current_word =~? '\w\+'
    execute 'TernType'
    return get(b:, 'tern_type', '')
  endif

  return ''
endfunction

let g:tern_map_keys = 0
let g:tern_show_signature_in_pum = 1
let prefix = '<LocalLeader>'
execute 'nnoremap <buffer> '.prefix.'td' ':TernDef<CR>'
execute 'nnoremap <buffer> '.prefix.'tr' ':TernRefs<CR>'
execute 'nnoremap <buffer> '.prefix.'tR' ':TernRename<CR>'
"}}}

" UltiSnips"{{{
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
" }}}

" YouCompleteMe"{{{
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" }}}

" WebDevIcons {{{
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['rakefile'] = ''
" }}}

" vim: set foldmethod=marker :
