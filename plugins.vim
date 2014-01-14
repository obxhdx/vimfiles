filetype off " Required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Utilities
Bundle 'gmarik/vundle'
Bundle 'jaytang0923/taglist.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mhinz/vim-startify'
Bundle 'obxhdx/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'

" Editing helpers
Bundle 'Raimondi/delimitMate'
Bundle 'Valloric/YouCompleteMe'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'msanders/snipmate.vim'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tmhedberg/matchit'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'

" Syntax files
Bundle 'slim-template/vim-slim'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'

" Colors
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'

filetype plugin indent on " Required

" Gundo
map <leader>g :GundoToggle<CR>

" Markdown folding
let g:markdown_fold_style = 'nested'

" Sparkup
let g:sparkupExecuteMapping = '<leader>e'
let g:sparkupNextMapping = '<leader>n'

" NERDTree
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <leader>p :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_dividers_override = ['', [0x2502], '', [0x2502]]
let g:Powerline_stl_path_style = 'filename'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " Bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " Define a new command 'Ag' to search for the provided text
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

" Taglist
let Tlist_Use_Right_Window = 1
nnoremap <Leader>l :TlistToggle<CR>

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<Down>']

" Startify
let g:ctrlp_reuse_window  = 'startify'
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
