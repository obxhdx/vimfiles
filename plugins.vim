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
Plug 'jgdavey/vim-blockle', { 'on': '<Plug>BlockToggle' }
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" }}}

" Code Lint"{{{
Plug 'sareyko/neat.vim', { 'on': 'Neat' }
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }
" }}}

" Color Schemes"{{{
Plug 'altercation/vim-colors-solarized'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'gosukiwi/vim-atom-dark'
Plug 'ronny/birds-of-paradise.vim'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
" }}}

" Git"{{{
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'tpope/vim-fugitive'
" }}}

" Misc"{{{
Plug 'chrisbra/Recover.vim'
Plug 'junegunn/limelight.vim'
Plug 'kshenoy/vim-signature'
Plug 'xolox/vim-misc' " Dependency for vim-notes
Plug 'xolox/vim-notes', { 'on': 'Note' }
" }}}

" Navigation"{{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'deris/vim-shot-f'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl' " Dependency for vim-oblique
Plug 'terryma/vim-smooth-scroll'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-unimpaired'
" }}}

" Syntax Utils"{{{
Plug 'dzeban/vim-log-syntax'
Plug 'gregsexton/MatchTag'
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
Plug 'obxhdx/slimux', { 'on': [ 'SlimuxREPLSendLine', 'SlimuxREPLSendSelection', 'SlimuxShellLast',
      \ 'SlimuxShellPrompt', 'SlimuxSendKeysLast', 'SlimuxSendKeysPrompt' ] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install', 'on': 'FZF' }
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
" }}}

call plug#end()

" }}}

" On-demand Activation"{{{

augroup InitCompletionPlugins
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe', 'delimitMate', 'vim-snippets')
        \| call youcompleteme#Enable() | autocmd! InitCompletionPlugins
augroup END

augroup InitGitPlugins
  autocmd!
  autocmd BufEnter * call LoadGitGutter()
augroup END

function! LoadGitGutter()
  if !empty(fugitive#head())
    call plug#load('vim-gitgutter')
    GitGutterEnable
  endif
endfunction
" }}}

" Plugin Customizations"{{{

" Blockle {{{
let g:blockle_mapping = ''
nmap sb <Plug>BlockToggle
"}}}

" Colorscheme {{{
try
  colorscheme badwolf
catch
endtry
" }}}

" BufTabline"{{{
let g:buftabline_show = 1
let g:buftabline_numbers = 1
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
nnoremap <Leader>zf :FZF<CR>
nnoremap <Leader>zl :LoadFZF<CR>:FZFLines<CR>

command! LoadFZF if stridx(&rtp, g:plugs.fzf.dir) <= 0 | call plug#load('fzf') | endif

command! FZFLines call fzf#run({
      \ 'source': s:FZFBuffersLines(),
      \ 'sink': function('s:FZFLineHandler'),
      \ 'options': '--extended --nth=3..,',
      \ 'tmux_height': '40%'
      \})

function! s:FZFLineHandler(l)
  let keys = split(a:l, ':\t')
  exec 'buf ' . keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:FZFBuffersLines()
  let results = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(results, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return reverse(results)
endfunction
" }}}

" GitGutter"{{{
let g:gitgutter_map_keys = 0
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
" }}}

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
autocmd FileType nerdtree nnoremap <silent> <buffer> <C-j> :call nerdtree#ui_glue#invokeKeyMap(g:NERDTreeMapActivateNode)<CR>

map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>

hi NERDTreeCWD       ctermfg=2    ctermbg=NONE  cterm=NONE
hi NERDTreeDir       ctermfg=240  ctermbg=NONE  cterm=NONE
hi NERDTreeFile      ctermfg=246  ctermbg=NONE  cterm=NONE
hi NERDTreeOpenable  ctermfg=3    ctermbg=NONE  cterm=NONE

function! NERDTreeHighlightFile(extension, fg, bg, mod)
  exec 'autocmd filetype nerdtree syn match ' . a:extension . ' #^\s\+.*' . a:extension . '\*\?$#'
  exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermbg=' . a:bg . ' ctermfg=' . a:fg . ' cterm=' . a:mod
endfunction

call NERDTreeHighlightFile('css',         '13',   'NONE',  'NONE')
call NERDTreeHighlightFile('feature',     '41',   'NONE',  'NONE')
call NERDTreeHighlightFile('gradle',      '222',  'NONE',  'NONE')
call NERDTreeHighlightFile('groovy',      '131',  'NONE',  'NONE')
call NERDTreeHighlightFile('html',        '215',  'NONE',  'NONE')
call NERDTreeHighlightFile('java',        '130',  'NONE',  'NONE')
call NERDTreeHighlightFile('js',          '201',  'NONE',  'NONE')
call NERDTreeHighlightFile('json',        '191',  'NONE',  'NONE')
call NERDTreeHighlightFile('md',          '184',  'NONE',  'NONE')
call NERDTreeHighlightFile('properties',  '229',  'NONE',  'NONE')
call NERDTreeHighlightFile('rb',          '197',  'NONE',  'NONE')
call NERDTreeHighlightFile('sh',          '208',  'NONE',  'NONE')
call NERDTreeHighlightFile('vim',         '255',  'NONE',  'NONE')
call NERDTreeHighlightFile('xml',         '210',  'NONE',  'NONE')
call NERDTreeHighlightFile('yaml',        '229',  'NONE',  'NONE')
call NERDTreeHighlightFile('yml',         '229',  'NONE',  'NONE')
" }}}

" Notes"{{{
let g:notes_directories = [ '~/Dropbox/Notes' ]
let g:notes_suffix = '.txt'

autocmd FileType notes if bufname('%') =~ 'tasks\|todo' | call EnableTodoMode() | endif
autocmd FileType notes au CursorHold,InsertLeave <buffer> write

function! EnableTodoMode()
  syntax match notesGroupHeading /\v^(%1l|TODO|XXX|FIXME|CURRENT|INPROGRESS|STARTED|WIP|DONE|.*:|[^A-Za-z]|$)@!.{1,50}$/ contains=@notesInline
  syntax match notesDoneItem /\v^<DONE>.*$/ contains=@notesInline

  highlight link notesGroupHeading markdownH1
  highlight link notesFixme ErrorMsg
  highlight link notesTodo WarningMsg
  highlight notesDoneMarker term=standout cterm=bold ctermfg=237 gui=bold guifg=#444444

  nnoremap tt :call ChangeTaskStatus('TODO')<CR>
  nnoremap ti :call ChangeTaskStatus('INPROGRESS')<CR>
  nnoremap td :call ChangeTaskStatus('DONE')<CR>
  nnoremap tf :call ChangeTaskStatus('FIXME')<CR>
  nnoremap tn :normal oTODO <CR>a
endfunction

function! ChangeTaskStatus(status)
  let l:regex = 's/\<\(TODO\|XXX\|FIXME\|CURRENT\|INPROGRESS\|STARTED\|WIP\|DONE\)\>/' . a:status
  silent! call ExecPreservingCursorPos(l:regex)
  write
endfunction
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
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
" }}}

" Shot-F {{{
hi! ShotFGraph cterm=bold ctermbg=235 ctermfg=51
"}}}

" Smooth Scroll"{{{
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 15, 4)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 15, 4)<CR>
nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 15, 4)<CR>
nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 15, 4)<CR>
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

nmap <C-c><C-c> :SlimuxREPLSendLine<CR>
vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nmap <C-c>s :SlimuxShellLast<CR>
nmap <C-c><C-s> :SlimuxShellPrompt<CR>
nmap <C-c>k :SlimuxSendKeysLast<CR>
nmap <C-c><C-k> :SlimuxSendKeysPrompt<CR>
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
let g:syntastic_ruby_checkers = [ 'rubocop' ]
let g:syntastic_sh_checkers = [ 'shellcheck' ]
let g:syntastic_zsh_checkers = [ 'zsh' ]
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': [] }
" }}}

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
let g:webdevicons_enable_airline_tabline = 0
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_nerdtree = 0
autocmd VimEnter * let g:webdevicons_enable_nerdtree = 1
" }}}

" vim: set foldmethod=marker :
