" Run 'vim -u ~/.vimbundles +BundleInstall +qall' to install all bundles

set nocompatible " Be iMproved

filetype off " required

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Github bundles "{{{
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/MatchTag'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'shawncplus/Vim-toCterm'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'underlog/ClosePairs'
Bundle 'vim-scripts/gitignore'
Bundle 'vim-scripts/indexer.tar.gz'
Bundle 'vim-scripts/matchit.zip'
Bundle 'yurifury/hexHighlight'
" "}}}

" Git bundles "{{{
Bundle 'git://git.wincent.com/command-t.git'
" "}}}

" Blueish colors "{{{
Bundle 'vim-scripts/dusk'
Bundle 'vim-scripts/oceandeep'
" "}}}

" Dark colors "{{{
Bundle 'eddsteel/vim-lanai'
Bundle 'oguzbilgic/sexy-railscasts-theme'
Bundle 'sickill/vim-monokai'
Bundle 'tpope/vim-vividchalk'
Bundle 'tomasr/molokai'
Bundle 'vim-scripts/Mustang2'
Bundle 'vim-scripts/paintbox'
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color'
Bundle 'vim-scripts/Sift'
Bundle 'vim-scripts/Tango2'
Bundle 'vim-scripts/The-Vim-Gardener'
Bundle 'vim-scripts/twilight'
Bundle 'vim-scripts/Wombat'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'vim-scripts/Zenburn'
" "}}}

" Light colors "{{{
Bundle 'altercation/vim-colors-solarized'
Bundle 'ChrisKempson/Vim-Tomorrow-Theme'
Bundle 'gregsexton/Gravity'
Bundle 'obxhdx/vim-github-theme'
Bundle 'vim-scripts/bclear'
Bundle 'vim-scripts/tango-morning.vim'
" "}}}

filetype plugin indent on " required

" CommandT settings "{{{
let g:CommandTNeverShowDotFiles = 1
" "}}}

" Indexer settings "{{{
let g:indexer_disableCtagsWarning = 1
let g:indexer_indexerListFilename = '.vimtags.cnf'
let g:indexer_tagsDirname = '.vimtags'
" "}}}
