" Just source this file and run :BundleInstall

set nocompatible " Be iMproved

filetype off " Required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Utilities
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'mileszs/ack.vim'
Bundle 'obxhdx/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'thomas-glaessle/hexHighlight'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/indexer.tar.gz'
" Dependencies only
Bundle 'mattn/webapi-vim'
Bundle 'vim-scripts/DfrankUtil'
Bundle 'vim-scripts/vimprj'

" Editing helpers
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'lammermann/AutoComplPop'
Bundle 'msanders/snipmate.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tmhedberg/matchit'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'

" Syntax files
Bundle 'bbommarito/vim-slim'
Bundle 'juvenn/mustache.vim'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'

" Colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'obxhdx/vim-railscasts-theme'
Bundle 'sjl/badwolf'
Bundle 'taxilian/Wombat'
Bundle 'tomasr/molokai'
Bundle 'trapd00r/neverland-vim-theme'

filetype plugin indent on " Required

" ctrlp
noremap <leader>o :CtrlPBuffer<CR>
let g:ctrlp_root_markers = ['.htaccess']
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '[\/]\.[^\/]\+$\|\.git$\|\.hg$\|\.svn$\|htdocs$\|opt$\|workspace-.\+$',
  \ 'file': '[\/]\.[^\/]\+$\|\.exe$\|\.so$\|\.dll$',
  \ 'link': '[\/]\.[^\/]\+$\|SOME_BAD_SYMBOLIC_LINKS',
  \ }

" Powerline
let g:Powerline_theme = 'obxhdx'
let g:Powerline_colorscheme = 'obxhdx'
let g:Powerline_symbols = 'fancy'

" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Indexer
let g:indexer_disableCtagsWarning = 1

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" NERDTree
let NERDTreeDirArrows = 0
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <leader>p :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR><C-w><C-w>

" Sparkup
let g:sparkupExecuteMapping = '<leader>e'
let g:sparkupNextMapping = '<leader>n'

" Gundo
map <leader>g :GundoToggle<CR>

" Ruby autocomplete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
