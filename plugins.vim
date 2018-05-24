if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations {{{
call plug#begin('~/.vim/bundle')

" Appearance
Plug 'blueyed/vim-diminactive'
Plug 'noahfrederick/vim-noctu'
Plug 'sheerun/vim-polyglot'

" Code Completion
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'jiangmiao/auto-pairs'
Plug 'shougo/neocomplete.vim', { 'on': [] }
Plug 'sirver/ultisnips', { 'on': [] }
Plug 'tpope/vim-endwise', { 'on': [] }

" Lint
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
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
function! FindAndReplaceWithWordBoundary(text)
  let l:use_word_boundary = 1
  execute s:FindAndReplace(a:text, l:use_word_boundary)
endfunction

function! FindAndReplaceWithoutWordBoundary(text)
  let l:use_word_boundary = 0
  execute s:FindAndReplace(a:text, l:use_word_boundary)
endfunction

function! s:FindAndReplace(text, use_word_boundary)
  let l:pattern = a:use_word_boundary ? '<'.a:text.'>' : a:text
  let l:new_text = input('Replace '.l:pattern.' with: ', a:text)

  if len(l:new_text)
    execute ',$s/\v'.l:pattern.'/'.l:new_text.'/gc'
  endif
endfunction

function! GrepWithFZF(text)
  execute 'FzRg '.a:text
endfunction

autocmd! User MapActions
autocmd User MapActions call MapAction('GrepWithFZF', '<leader>g')
autocmd User MapActions call MapAction('FindAndReplaceWithWordBoundary', '<leader>r')
autocmd User MapActions call MapAction('FindAndReplaceWithoutWordBoundary', '<leader><leader>r')
"}}}

" Ale {{{
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
au ColorScheme * hi ALEErrorSign ctermfg=red
au ColorScheme * hi ALEWarningSign ctermfg=yellow
" }}}

" AutoHighlightWord {{{
au VimEnter * hi! AutoHighlightWord ctermbg=238
" }}}

" Colorscheme {{{
augroup ColorTweaks
  autocmd!
  autocmd ColorScheme *
        \   hi ColorColumn ctermbg=237 |
        \   hi CursorLine ctermbg=237 |
        \   hi CursorLineNr ctermbg=NONE ctermfg=white |
        \   hi LineNr ctermbg=NONE |
        \   hi Pmenu ctermbg=13 ctermfg=black |
        \   hi StatusLine cterm=reverse |
        \   hi StatusLineNC cterm=NONE ctermbg=239 ctermfg=white |
        \   hi VertSplit ctermfg=240 |
        \   hi! link Folded Comment |
augroup END

try
  colorscheme noctu
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
hi SignifySignAdd ctermfg=green
hi SignifySignChange ctermfg=yellow
hi SignifySignDelete ctermfg=red

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
