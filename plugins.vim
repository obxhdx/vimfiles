if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations {{{
call plug#begin('~/.vim/bundle')

" Appearance
Plug 'blueyed/vim-diminactive'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sheerun/vim-polyglot'

" Code Completion
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'jiangmiao/auto-pairs'
Plug 'shougo/neocomplete.vim', { 'on': [] }
Plug 'sirver/ultisnips', { 'on': [] }
Plug 'tpope/vim-endwise', { 'on': [] }

" Lint
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'w0rp/ale'

" Misc
Plug 'junegunn/vim-slash'
Plug 'mhinz/vim-signify'
Plug 'obxhdx/vim-action-mapper'
Plug 'obxhdx/vim-auto-highlight'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

" Navigation
Plug 'kopischke/vim-fetch'
Plug 'tmhedberg/matchit'

" Tools
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'metakirby5/codi.vim'

call plug#end()
" }}}

" On-demand Loading {{{
augroup LoadCompletionPlugins
  autocmd!
  if !has('gui_vimr')
    autocmd InsertEnter * call plug#load('neocomplete.vim', 'ultisnips', 'vim-endwise', 'vim-snippets')
          \| echo 'Snippets + Completion plugins loaded!'
          \| autocmd! LoadCompletionPlugins
  endif
augroup END
" }}}

" ActionMapper {{{
function! GrepWithFZF(text)
  execute 'FzRg '.a:text
endfunction

autocmd! User MapActions
autocmd User MapActions call MapAction('GrepWithFZF', '<leader>g')
"}}}

" Ale {{{
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
" }}}

" Colorscheme {{{
function! DefaultColorTweaks()
  hi Normal ctermbg=NONE guibg=NONE

  if $TERM_BACKGROUND == 'light'
    hi LineNr ctermbg=NONE
    hi SignColumn ctermbg=NONE
    hi ColorColumn ctermbg=NONE
    hi Pmenu ctermfg=232 ctermbg=225
  else
    hi LineNr ctermbg=235
    hi SignColumn ctermbg=235
    hi ColorColumn ctermbg=235
    hi Pmenu ctermfg=236 ctermbg=225
  endif
endfunction

augroup ColorTweaks
  autocmd!
  autocmd ColorScheme * call DefaultColorTweaks()
  autocmd ColorScheme one
        \   hi ALEErrorSign guibg=#2c323c |
        \   hi ALEWarningSign guibg=#2c323c |
        \   hi AutoHighlightWord guibg=#3a3a3a |
        \   hi IncSearch cterm=NONE guifg=#000000 guibg=#ff5f5f |
        \   hi LineNr guibg=#2c323c |
        \   hi MatchParen cterm=bold guifg=#87ff00 |
        \   hi Pmenu guifg=#303030 guibg=#ffd7ff |
        \   hi Search guibg=#aeee00 |
        \   hi StatusLine guifg=white guibg=#4b5263 |
        \   hi StatusLineNC gui=NONE guibg=#353b45 |
        \   hi VertSplit guifg=#262626 |
        \   hi! link SignColumn LineNr |
        \   hi! link Folded Comment |
  autocmd FileType markdown
        \   hi htmlH1 ctermfg=209 guifg=#ff8787 |
        \   hi htmlH2 ctermfg=156 guifg=#afff87 |
        \   hi htmlH3 ctermfg=205 guifg=#ff5faf |
        \   hi mkdString ctermfg=109 guifg=#89b8c2 |
        \   hi mkdCode ctermfg=109 guifg=#89b8c2 |
        \   hi mkdCodeStart ctermfg=109 guifg=#89b8c2 |
        \   hi mkdCodeEnd ctermfg=109 guifg=#89b8c2 |
        \   hi mkdFootnote ctermfg=242 guifg=#6b7089 |
        \   hi mkdBlockquote ctermfg=242 guifg=#6b7089 |
        \   hi mkdListItem cterm=NONE ctermfg=109 guifg=#89b8c2 |
        \   hi mkdRule cterm=NONE ctermfg=109 guifg=#89b8c2 |
        \   hi mkdLineBreak ctermbg=236 guibg=#272c42 |
        \   hi mkdID cterm=NONE ctermfg=109 guifg=#89b8c2 |
        \   hi mkdDelimiter ctermfg=252 guifg=#c6c8d1 |
augroup END

try
  colorscheme one
  set termguicolors
catch | endtry
" }}}

" Commentary {{{
map gc <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" }}}

" FZF {{{
let g:fzf_command_prefix = 'Fz'
let g:fzf_files_options  = '--tiebreak=end' " Prioritize matches that are closer to the end of the string
nnoremap <Leader>b  :FzBuffers<CR>
nnoremap <Leader>c  :FzCommands<CR>
nnoremap <Leader>f  :FzFiles<CR>
nnoremap <Leader>h  :FzHistory<CR>

command! -bang -nargs=* FzRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
" }}}

" Neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
"}}}

" Signify {{{
highlight SignifySignAdd guibg=#2c323c
highlight SignifySignChange guibg=#2c323c
highlight SignifySignDelete guibg=#2c323c

let g:signify_sign_add               = '│'
let g:signify_sign_delete            = '│'
let g:signify_sign_delete_first_line = '│'
let g:signify_sign_change            = '│'
let g:signify_sign_changedelete      = g:signify_sign_change
"}}}

" Slash {{{
noremap <silent> <plug>(slash-after) :execute 'match IncSearch /\c\%'.virtcol('.').'v\%'.line('.').'l'.@/.'/'<CR>
autocmd CursorMoved * call clearmatches()
"}}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}}

" vim: set foldmethod=marker :
