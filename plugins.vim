if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations {{{

call plug#begin('~/.vim/bundle')

" Appearance {{{
Plug 'ap/vim-buftabline'
Plug 'blueyed/vim-diminactive'
Plug 'itchyny/lightline.vim'
Plug 'zhaocai/GoldenView.Vim'
" }}}

" Code Completion {{{
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'ternjs/tern_for_vim', { 'on': [], 'do': 'npm install' }
Plug 'Shougo/neocomplete.vim', { 'on': [] }
Plug 'jiangmiao/auto-pairs'
Plug 'obxhdx/vim-extract-inline'
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
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'obxhdx/vim-action-mapper'
Plug 'obxhdx/vim-simple-task-manager'
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
Plug 'metakirby5/codi.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
" }}}

call plug#end()

" }}}

" Plugin Customizations {{{

" On-demand Loading {{{
augroup LoadCompletionPlugins
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets', 'tern_for_vim', 'neocomplete.vim')
        \| echo 'Snippets + Completion plugins loaded!'
        \| autocmd! LoadCompletionPlugins
augroup END
" }}}

" AutoHighlight {{{
let g:auto_highlight#disabled_filetypes = ['vim-plug', 'todo']
"}}}

" Colorscheme {{{
augroup ColorTweaks
  autocmd ColorScheme *
        \   hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse |
        \   hi Normal ctermbg=NONE |
        \   hi Pmenu ctermfg=236 ctermbg=218

  autocmd ColorScheme iceberg
        \   hi CursorLineNr ctermbg=235 |
        \   hi IncSearch ctermbg=203 ctermfg=232 cterm=NONE term=NONE |
        \   hi MatchParen ctermfg=203 ctermbg=234 |
        \   hi VertSplit ctermbg=NONE ctermfg=235 term=NONE cterm=NONE |
        \   hi Visual ctermbg=239 |
        \   hi! link Folded Comment |
        \   hi! link jpropertiesIdentifier Statement
augroup END

try
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
let g:fzf_command_prefix = 'Fz'
nnoremap <Leader>z :FzFiles<CR>
nnoremap <Leader>h :FzHistory<CR>
" }}}

" GoldenView {{{
let g:goldenview__enable_default_mapping = 0
nnoremap <C-W>c :close<CR>:EnableGoldenViewAutoResize<CR>
"}}}

" Grepper {{{
let g:grepper = {
      \   'highlight': 1,
      \   'switch': 0,
      \ }
nmap <Leader>g <plug>(GrepperOperator)
xmap <Leader>g <plug>(GrepperOperator)
autocmd User Grepper nmap ]q :exe "cnext \| normal \<Plug>(Oblique-n)"<CR>
autocmd User Grepper nmap [q :exe "cprevious \| normal \<Plug>(Oblique-n)"<CR>
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
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'modified' ], [ 'git_stats', 'trailing_whitespaces', 'mixed_indentation' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'LightLineMode',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \ },
      \ 'component_expand': {
      \   'trailing_whitespaces': 'LightLineTrailingSpaces',
      \   'mixed_indentation': 'LightLineMixedIndentation',
      \   'git_stats': 'LightLineGitStats',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

augroup ComponentExpand
  autocmd!
  autocmd BufReadPost,BufWritePost,InsertLeave * call s:LightLineUpdateComponents()
  autocmd CursorHold * call s:LightLineUpdateGitStats()
augroup END

function! s:LightLineUpdateGitStats()
  if exists('#lightline')
    call LightLineGitStats()
    call lightline#update()
  endif
endfunction

function! s:LightLineUpdateComponents()
  if exists('#lightline')
    call LightLineTrailingSpaces()
    call LightLineMixedIndentation()
    call lightline#update()
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return &ft !~ 'help' && winwidth(0) > 80 ? (branch !=# '' ? ' '.branch : '') : ''
  endif
endfunction

function! LightLineGitStats()
  return &ft !~ 'help' && winwidth(0) > 80 ? s:GitStatsSummary() : ''
endfunction

function! LightLineTrailingSpaces()
  if &ft =~ 'help' || winwidth(0) < 80 | return '' | endif
  let trailing = search('\s$', 'nw')
  return trailing > 0 ? '…(' . trailing . ')' : ''
endfunction

function! LightLineMixedIndentation()
  if &ft =~ 'help' || winwidth(0) < 80 | return '' | endif
  let tabs = search('^\t', 'nw')
  let spaces = search('^ ', 'nw')
  return (tabs > 0 && spaces > 0) ? '»(' . tabs . ')' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction

function! LightLineFileformat()
  return &ft =~ 'help' ? '' : winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return &ft =~ 'help' ? '' : winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  if &ft =~ 'help' || winwidth(0) < 40 | return '' | endif
  return winwidth(0) > 60 ? lightline#mode() : strpart(lightline#mode(), 0, 1)
endfunction

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.inactive.left    = [ ['gray7', 'gray2'], ['gray7', 'gray2'] ]
let s:p.inactive.middle  = [ ['gray7', 'gray2'] ]
let s:p.inactive.right   = [ ['gray7', 'gray2'], ['gray7', 'gray2'], ['gray7', 'gray2'] ]
let s:p.insert.left = [ ['darkestcyan', 'white'], ['white', 'darkblue'] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.normal.left = [ ['darkestgreen', 'brightgreen'], ['gray10', 'gray4'] ]
let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
let s:p.normal.right = [ ['gray5', 'gray10'], ['gray9', 'gray4'], ['gray8', 'gray2'] ]
let s:p.normal.error     = [ ['brightestred', 'gray2'] ]
let s:p.normal.warning   = [ ['brightorange', 'gray2'] ]
let s:p.replace.left = [ ['white', 'brightred'], ['white', 'gray4'] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray1' ] ]
let s:p.visual.left = [ ['darkred', 'brightorange'], ['white', 'gray4'] ]

let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(s:p)
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
let g:neocomplete#sources#omni#input_patterns.ruby = '\h\w*\|[^. \t]\.\w*'
if exists(":NeoComplete")
  call neocomplete#custom#source('tag', 'disabled', 1)
endif
" }}}

" Oblique {{{
let g:oblique#incsearch_highlight_all = 1
command! FreezeSearchMatches let g:oblique#clear_highlight = 0 | set hlsearch
command! UnfreezeSearchMatches let g:oblique#clear_highlight = 1 | set nohlsearch
"}}}

" Polyglot {{{
let g:jsx_ext_required = 1
"}}}

" Simple Task Manager {{{
autocmd ColorScheme * hi todoTitle            cterm=bold ctermfg=231
autocmd ColorScheme * hi todoHeading          cterm=bold ctermfg=11
autocmd ColorScheme * hi todoAtxHeading       cterm=none ctermfg=154
autocmd ColorScheme * hi todoPendingMarker    cterm=bold ctermfg=211 ctermbg=234
autocmd ColorScheme * hi todoProgressMarker   cterm=bold ctermfg=222
autocmd ColorScheme * hi todoHoldMarker       cterm=bold ctermfg=12
autocmd ColorScheme * hi todoDoneMarker       cterm=bold ctermfg=237
autocmd ColorScheme * hi todoDoneItem         cterm=none ctermfg=243
"}}}

" Signify {{{
let g:signify_sign_change = '~'
highlight SignifySignAdd    cterm=bold ctermbg=235 ctermfg=119
highlight SignifySignChange cterm=bold ctermbg=235 ctermfg=227
highlight SignifySignDelete cterm=bold ctermbg=235 ctermfg=167

function! s:GitStatsSummary()
  if exists('*sy#buffer_is_active()') && sy#buffer_is_active() == 0
    return ''
  endif

  let symbols = ['+', '-', '~']
  let [added, modified, removed] = sy#repo#get_stats()
  let stats = [added, removed, modified]
  let hunkline = ''

  for i in range(3)
    if stats[i] >= 0
      let hunkline .= printf('%s%s ', symbols[i], stats[i])
    endif
  endfor

  if !empty(hunkline)
    let hunkline = printf('%s', hunkline[:-2])
  endif

  return hunkline
endfunction
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
