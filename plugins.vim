if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations {{{

call plug#begin('~/.vim/bundle')

Plug '~/Projects/Lab/vim-extract-inline'

Plug '~/Projects/Lab/vim-simple-todo' " 'obxhdx/vim-simple-todo'
autocmd ColorScheme * hi todoTitle            cterm=bold ctermfg=231
autocmd ColorScheme * hi todoHeading          cterm=bold ctermfg=11
autocmd ColorScheme * hi todoAtxHeading       cterm=none ctermfg=154
autocmd ColorScheme * hi todoPendingMarker    cterm=bold ctermfg=211 ctermbg=234
autocmd ColorScheme * hi todoProgressMarker   cterm=bold ctermfg=222
autocmd ColorScheme * hi todoHoldMarker       cterm=bold ctermfg=12
autocmd ColorScheme * hi todoDoneMarker       cterm=bold ctermfg=237
autocmd ColorScheme * hi todoDoneItem         cterm=none ctermfg=243

" Appearance {{{
Plug 'ap/vim-buftabline'
Plug 'blueyed/vim-diminactive'
Plug 'itchyny/lightline.vim'
Plug 'zhaocai/GoldenView.Vim'
" }}}

" Code Completion {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-surround'
" }}}

" Code Linters/Formatters {{{
Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'css' ] }
Plug 'sareyko/neat.vim', { 'on': 'Neat' }
" }}}

" Color Schemes {{{
Plug 'chriskempson/base16-vim'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
" }}}

" Misc {{{
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'obxhdx/vim-action-mapper'
Plug 'tpope/vim-rsi'
" }}}

" Navigation {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
Plug 'kopischke/vim-fetch'
Plug 'obxhdx/vim-auto-highlight'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-unimpaired'
" }}}

" Syntax Utils {{{
Plug 'jelera/vim-javascript-syntax'
Plug 'sheerun/vim-polyglot'
" }}}

" Tools {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'obxhdx/slimux', { 'branch': 'pane-list', 'on': [ 'SlimuxREPLSendSelection' ] }
Plug 'tpope/vim-projectionist'
" }}}

call plug#end()

" }}}

" On-demand Loading {{{
augroup LoadGitGutter
  autocmd!
  autocmd BufWritePost * call plug#load('vim-gitgutter')
        \| GitGutterEnable
        \| autocmd! LoadGitGutter
augroup END
" }}}

" Plugin Customizations {{{

" ActionMapper {{{
autocmd! User MapActions
autocmd User MapActions call MapAction('SlimuxREPLSendSelection', '<leader>t')
autocmd User MapActions call MapAction('Ag', '<leader>g')
"}}}

" AutoHighlight {{{
let g:auto_highlight#disabled_filetypes = ['vim-plug', 'todo']
"}}}

" Colorscheme {{{
try
  set term=screen-256color
  set t_Co=256
  set background=dark
  let base16colorspace=256
  colorscheme iceberg
catch | endtry
" }}}

" BufTabline {{{
let g:buftabline_show = 1
let g:buftabline_indicators = 1
hi BufTabLineCurrent ctermbg=203 ctermfg=232 guibg=#ff5f5f guifg=#080808
hi BufTabLineActive ctermbg=236 ctermfg=203 guibg=#303030 guifg=#ff5f5f
hi BufTabLineHidden ctermbg=236 guibg=#303030
hi BufTabLineFill ctermbg=236 guibg=#303030
" }}}

" Commentary {{{
map gc <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" }}}

" FZF {{{
let g:fzf_command_prefix = 'Fzf'
nnoremap <Leader>z :FzfFiles<CR>
cabbr Ag FzfAg
" }}}

" GitGutter {{{
let g:gitgutter_eager = 0
let g:gitgutter_map_keys = 0
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
" }}}

" GoldenView {{{
let g:goldenview__enable_default_mapping = 0
nnoremap <C-W>c :close<CR>:EnableGoldenViewAutoResize<CR>
"}}}

" JsBeautify "{{{
augroup JsBeautify
  autocmd!
  autocmd FileType javascript noremap <buffer> <Leader>= :call JsBeautify()<CR>
  autocmd FileType html noremap <buffer> <Leader>= :call HtmlBeautify()<CR>
  autocmd FileType css noremap <buffer> <Leader>= :call CSSBeautify()<CR>
augroup END
"}}}

" Lightline {{{
try
  source $HOME/.vim/lightline.vim
  set noshowmode
catch | endtry
"}}}

" Neat {{{
let neat#json#commands = [ '%!jq .' ]
"}}}

" NeoComplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#omni#functions = {}
let g:neocomplete#sources#omni#functions.javascript = 'tern#Complete'
let g:neocomplete#sources#omni#input_patterns = {}
let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
call neocomplete#custom#source('tag', 'disabled', 1)
" }}}

" Oblique {{{
let g:oblique#incsearch_highlight_all = 1
command! FreezeSearchMatches let g:oblique#clear_highlight = 0 | set hlsearch
command! UnfreezeSearchMatches let g:oblique#clear_highlight = 1 | set nohlsearch
"}}}

" Polyglot {{{
let g:jsx_ext_required = 1
"}}}

" Slimux {{{
let g:slimux_select_from_current_window = 1
let g:slimux_pane_format = '[#{session_name}] #{window_index}.#{pane_index} [#{window_name}] #{pane_title}'

au FileType slimux syntax match slimuxPaneId /\v^\%[0-9]+\ze:/
au FileType slimux syntax match slimuxPaneIndex /\v[0-9]+\.[0-9]+/
au FileType slimux syntax match slimuxSessionOrWindowName /\v\s\[[[:alnum:]]+\]\s/

hi def link slimuxPaneId WarningMsg
hi def link slimuxPaneIndex Constant
hi def link slimuxSessionOrWindowName Title

function! s:SendKeysToREPL()
  let l:keys = ""
  if getchar(1)
    let l:keys = nr2char(getchar())
  endif
  call SlimuxSendKeys(l:keys)
  call feedkeys("\<Esc>")
  return ""
endfunction

imap <C-y><Esc> <Nop> | imap <C-y> <C-r>=<SID>SendKeysToREPL()<cr>
nnoremap <Leader>k :call feedkeys("i\<C-y>")<CR>
"}}}

" Tern.js {{{
let g:tern_map_keys = 0
let g:tern_show_argument_hints = "on_hold"
let g:tern_show_signature_in_pum = 1
"}}}

" UltiSnips {{{
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" }}}

" }}}

" vim: set foldmethod=marker :
