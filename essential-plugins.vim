if empty(glob('~/.vim/bundle'))
  autocmd VimEnter * PlugInstall
endif

" Plugin Declarations {{{
call plug#begin('~/.vim/bundle')

" Appearance
Plug 'blueyed/vim-diminactive'
Plug 'cocopon/iceberg.vim'
Plug 'sheerun/vim-polyglot'

" Misc
Plug 'mhinz/vim-signify'
Plug 'obxhdx/vim-action-mapper'
Plug 'obxhdx/vim-auto-highlight'
Plug 'obxhdx/vim-extract-inline'
Plug 'pgdouyon/vim-evanesco'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/matchit'

" Tools
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-key-bindings --no-completion --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'css' ] }
Plug 'metakirby5/codi.vim'

call plug#end()
" }}}

" ActionMapper {{{
function! GrepWithFZF(text)
  execute 'FzAg '.a:text
endfunction
autocmd! User MapActions
autocmd User MapActions call MapAction('GrepWithFZF', '<leader>g')
"}}}

" Colorscheme {{{
augroup ColorTweaks
  autocmd ColorScheme *
        \   hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse |
        \   hi Normal ctermbg=NONE |
        \   hi LineNr ctermbg=235 |
        \   hi SignColumn ctermbg=235 |
        \   hi ColorColumn ctermbg=235 |
        \   hi Pmenu ctermfg=236 ctermbg=218

  autocmd ColorScheme iceberg
        \   hi CursorLineNr ctermbg=235 |
        \   hi htmlH2 ctermfg=156 |
        \   hi IncSearch ctermbg=203 ctermfg=232 cterm=NONE term=NONE |
        \   hi MatchParen ctermfg=203 ctermbg=234 |
        \   hi netrwMarkFile cterm=underline |
        \   hi StatusLineNC ctermfg=241 ctermbg=236 cterm=NONE term=NONE |
        \   hi StatusLine cterm=NONE ctermfg=white ctermbg=240 |
        \   hi VertSplit ctermbg=NONE ctermfg=235 term=NONE cterm=NONE |
        \   hi Visual ctermbg=239 |
        \   hi! link jpropertiesIdentifier Statement
augroup END

try
  set t_Co=256
  set background=dark
  let base16colorspace=256

  if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes work
    " properly within 256-color terminals
    set t_ut=
  endif

  colorscheme iceberg
catch | endtry
" }}}

" Commentary {{{
map gc <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" }}}

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
"}}}

" FZF {{{
let g:fzf_command_prefix = 'Fz'
let g:fzf_files_options  = '--tiebreak=end' " Prioritize matches that are closer to the end of the string
nnoremap <leader>ag :FzAg<CR>
nnoremap <Leader>b  :FzBuffers<CR>
nnoremap <Leader>f  :FzFiles<CR>
nnoremap <Leader>h  :FzHistory<CR>
" }}}

" JsBeautify "{{{
augroup JsBeautify
  autocmd!
  autocmd FileType javascript noremap <buffer> <Leader>= :call JsBeautify()<CR>
  autocmd FileType html noremap <buffer> <Leader>= :call HtmlBeautify()<CR>
  autocmd FileType css noremap <buffer> <Leader>= :call CSSBeautify()<CR>
augroup END
"}}}

" rsi {{{
augroup rsiTweaks
  autocmd!
  autocmd VimEnter * cunmap <C-g>
  autocmd VimEnter * cunmap <C-t>
augroup END
"}}}

" Signify {{{
highlight SignifySignAdd    cterm=bold ctermbg=235 ctermfg=108
highlight SignifySignChange cterm=bold ctermbg=235 ctermfg=216
highlight SignifySignDelete cterm=bold ctermbg=235 ctermfg=168

let g:signify_sign_add               = '│'
let g:signify_sign_delete            = '│'
let g:signify_sign_delete_first_line = '│'
let g:signify_sign_change            = '│'
let g:signify_sign_changedelete      = g:signify_sign_change
"}}}

" vim: set foldmethod=marker :
