" Run 'vim -u ~/.vim/vimbundles.vim +BundleInstall +qall' to install bundles

set nocompatible " be iMproved

filetype off " required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Github bundles "{{{
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'msanders/snipmate.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'shawncplus/Vim-toCterm'
Bundle 'sjl/gundo.vim'
Bundle 'tmhedberg/matchit'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/DfrankUtil'
Bundle 'vim-scripts/indexer.tar.gz'
Bundle 'vim-scripts/vimprj'
Bundle 'xolox/vim-shell'
Bundle 'yurifury/hexHighlight'
" "}}}

" Own repos "{{{
Bundle 'obxhdx/vim-github-theme'
Bundle 'obxhdx/vim-powerline'
Bundle 'obxhdx/vim-railscasts-theme'
" "}}}

" Colorschemes "{{{
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'
Bundle 'vim-scripts/bclear'
" "}}}

filetype plugin indent on " required

" Indexer settings "{{{
let g:indexer_disableCtagsWarning = 1
let g:indexer_indexerListFilename = '.indexer_files'
let g:indexer_tagsDirname = '.vimtags'
" "}}}

" ctrlp settings "{{{
let g:ctrlp_root_markers = ['.htaccess']
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '[\/]\.[^\/]\+$\|\.git$\|\.hg$\|\.svn$\|htdocs$\|opt$\|workspace-.\+$',
  \ 'file': '[\/]\.[^\/]\+$\|\.exe$\|\.so$\|\.dll$',
  \ 'link': '[\/]\.[^\/]\+$\|SOME_BAD_SYMBOLIC_LINKS',
  \ }
" "}}}

" neocomplcache settings "{{{
let g:neocomplcache_enable_at_startup = 1
" "}}}

" vim-powerline settings "{{{
let g:Powerline_theme = 'obxhdx'
let g:Powerline_colorscheme = 'obxhdx'
" "}}}
