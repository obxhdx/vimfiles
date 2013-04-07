filetype off " Required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Utilities
Bundle 'gmarik/vundle'
Bundle 'kassio/ColorSelect'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'obxhdx/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'thomas-glaessle/hexHighlight'
Bundle 'tpope/vim-fugitive'

" Editing helpers
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'msanders/snipmate.vim'
Bundle 'nelstrom/vim-markdown-folding'
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
Bundle 'vim-ruby/vim-ruby'

" Colors
Bundle 'sjl/badwolf'
Bundle 'taxilian/Wombat'
Bundle 'tomasr/molokai'
Bundle 'trapd00r/neverland-vim-theme'

filetype plugin indent on " Required

" Colorscheme
set background=dark
color badwolf

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
let g:Powerline_symbols = 'fancy'
let g:Powerline_dividers_override = ['', [0x2502], '', [0x2502]]
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_colorscheme = 'custom'
call Pl#Theme#InsertSegment('extra:indicators', 'after', 'fileinfo')
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" NERDTree
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeQuitOnOpen = 1
map <leader>p :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Sparkup
let g:sparkupExecuteMapping = '<leader>e'
let g:sparkupNextMapping = '<leader>n'

" Gundo
map <leader>g :GundoToggle<CR>

" Markdown folding
let g:markdown_fold_style = 'nested'

" Ruby autocomplete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
