#!/bin/bash

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function error_msg {
  error_sign="\xe2\x9c\x98"
  printf "$COL_RED$error_sign $1$COL_RESET\n" >&2
}

function warn_msg {
  warn_sign="\xe2\x9a\xa0"
  printf "$COL_YELLOW$warn_sign $1$COL_RESET\n" >&2
}

function info_msg {
  info_sign="\xE2\x97\x8f"
  printf "$COL_BLUE$info_sign $1$COL_BLUE\n" >&2
}

function ok_msg {
  check_mark="\xe2\x9c\x93"
  printf "$COL_GREEN$check_mark $1$COL_RESET\n" >&2
}

# Clone vimfiles repo
VIMFILES_PATH="$PWD/vimfiles"
if ! [[ -d $VIMFILES_PATH ]]; then
  git clone --recursive https://github.com/obxhdx/vimfiles
  ok_msg "Vimfiles repo cloned at $VIMFILES_PATH"
else
  warn_msg "Folder $VIMFILES_PATH already exists"
fi

# # Clone vundle repo
# path="$HOME/.vim/bundle/vundle"
# if ! [[ -d $path ]]; then
#   mkdir -p $HOME/.vim/bundle/vundle
#   git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
#   ok_msg "Vimfiles repo cloned at $path"
# else
#   warn_msg "Folder $path already exists"
# fi

# Symlink repo to .vim
target="$HOME/.vim"
if ! [[ -h $target ]]; then
  ln -s $VIMFILES_PATH $target
  ok_msg "$VIMFILES_PATH symlinked to $target"
else
  warn_msg "Symlink $target already exists"
fi

# Symlink *rc files
for file in 'vimrc' 'gvimrc'; do
  origin="$VIMFILES_PATH/$file"
  target="$HOME/.$file"

  if ! [[ -h $target ]]; then
    ln -s $origin $target
    ok_msg "$origin symlinked to $target"
  else
    warn_msg "Symlink $target already exists"
  fi;
done;

# Create vimbackup folder
path="$HOME/.vimbackup"
if ! [[ -d $path ]]; then
  mkdir $path
  ok_msg "$path created"
else
  warn_msg "Folder $path already exists"
fi

# Install bundles
vim -u $VIMFILES_PATH/plugins.vim +BundleInstall +qall
ok_msg 'Bundles installed'

# Uninstall script
# TODO
