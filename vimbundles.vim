" Run 'vim -u ~/.vimbundles +BundleInstall +qall' to install all bundles

set nocompatible " Be iMproved

filetype off " required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Github bundles "{{{
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'obxhdx/snipmate-snippets'
Bundle 'obxhdx/vim-powerline'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdtree'
Bundle 'shawncplus/Vim-toCterm'
Bundle 'Shougo/neocomplcache'
Bundle 'sjl/gundo.vim'
Bundle 'spf13/PIV'
Bundle 'tmhedberg/matchit'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/gitignore'
Bundle 'vim-scripts/indexer.tar.gz'
Bundle 'yurifury/hexHighlight'
" "}}}

" Dark colors "{{{
Bundle 'obxhdx/vim-railscasts-theme'
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'
" "}}}

" Light colors "{{{
Bundle 'altercation/vim-colors-solarized'
Bundle 'obxhdx/vim-github-theme'
Bundle 'vim-scripts/bclear'
" "}}}

filetype plugin indent on " required

" Indexer settings "{{{
let g:indexer_disableCtagsWarning = 1
let g:indexer_indexerListFilename = '.indexer_files'
let g:indexer_tagsDirname = '.vimtags'
" "}}}

" vim-ruby autocomplete settings "{{{
au FileType ruby,eruby set omnifunc=rubycomplete#Complete
au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
au FileType ruby,eruby let g:rubycomplete_rails = 1
au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" "}}}

" ctrlp settings "{{{
let g:ctrlp_working_path_mode = 0
" "}}}

" neocomplcache settings "{{{
let g:neocomplcache_enable_at_startup = 1
" "}}}

" vim-powerline settings "{{{
let g:Powerline_theme = 'obxhdx'
let g:Powerline_colorscheme = 'obxhdx'
" "}}}
