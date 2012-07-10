" Run 'vim -u ~/.vim/bundles.vim +BundleInstall +qall' to install bundles

set nocompatible " be iMproved

filetype off " required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Utilities "{{{
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'lammermann/AutoComplPop'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'obxhdx/vim-powerline'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'thomas-glaessle/hexHighlight'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/DfrankUtil'
Bundle 'vim-scripts/vimprj'
Bundle 'vim-scripts/indexer.tar.gz'
" "}}}

" General editing utilities "{{{
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'kana/vim-smartinput'
Bundle 'msanders/snipmate.vim'
Bundle 'tmhedberg/matchit'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
" "}}}

" Syntax files "{{{
Bundle 'bbommarito/vim-slim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
" "}}}

" Colors "{{{
Bundle 'altercation/vim-colors-solarized'
Bundle 'obxhdx/vim-railscasts-theme'
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'
Bundle 'trapd00r/neverland-vim-theme'
" "}}}

filetype plugin indent on " required

" ctrlp settings "{{{
let g:ctrlp_root_markers = ['.htaccess']
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '[\/]\.[^\/]\+$\|\.git$\|\.hg$\|\.svn$\|htdocs$\|opt$\|workspace-.\+$',
  \ 'file': '[\/]\.[^\/]\+$\|\.exe$\|\.so$\|\.dll$',
  \ 'link': '[\/]\.[^\/]\+$\|SOME_BAD_SYMBOLIC_LINKS',
  \ }
" "}}}

" vim-powerline settings "{{{
let g:Powerline_theme = 'obxhdx'
let g:Powerline_colorscheme = 'obxhdx'
let g:Powerline_symbols = 'fancy'
" "}}}

" Ack settings "{{{
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" "}}}
