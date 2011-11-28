" ### Vundle and bundles settings

filetype off "required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" ## My Bundles

" Github repos

Bundle 'gregsexton/MatchTag'
Bundle 'msanders/snipmate.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'shawncplus/Vim-toCterm'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'underlog/ClosePairs'
Bundle 'vim-scripts/gitignore'
Bundle 'vim-scripts/matchit.zip'
Bundle 'xolox/vim-easytags'
Bundle 'yurifury/hexHighlight'

" Non Github repos
Bundle 'git://git.wincent.com/command-t.git'

" ## My Colors

" Blueish colors
Bundle 'vim-scripts/dusk'
Bundle 'vim-scripts/oceandeep'

" Dark colors
Bundle 'eddsteel/vim-lanai'
Bundle 'oguzbilgic/sexy-railscasts-theme'
Bundle 'sickill/vim-monokai'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/molokai'
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

" Light colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'ChrisKempson/Vim-Tomorrow-Theme'
Bundle 'gregsexton/Gravity'
Bundle 'obxhdx/vim-github-theme'
Bundle 'vim-scripts/bclear'
Bundle 'vim-scripts/tango-morning.vim'

filetype plugin indent on "required
