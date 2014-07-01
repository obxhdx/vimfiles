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

VIMFILES_LOCAL_DIR="$PWD/vimfiles"
VIMFILES_GIT_REPO="https://github.com/obxhdx/vimfiles"

# Clone vimfiles repo
if [[ -d $VIMFILES_LOCAL_DIR ]]; then
  warn_msg "Folder $VIMFILES_LOCAL_DIR already exists. Exiting..."
  exit
elif [[ `git config --get remote.origin.url` == $VIMFILES_GIT_REPO ]]; then
  warn_msg "Current dir is already a copy of $VIMFILES_GIT_REPO"
  VIMFILES_LOCAL_DIR="$PWD"
else
  git clone $VIMFILES_GIT_REPO
  ok_msg "Vimfiles repo cloned at $VIMFILES_LOCAL_DIR"
fi

# Clone Vundle repo
vundle_dir="$VIMFILES_LOCAL_DIR/bundle/Vundle.vim"
if ! [[ -d $vundle_dir ]]; then
  git clone "https://github.com/gmarik/Vundle.vim" $vundle_dir
  ok_msg "Vundle repo cloned at $vundle_dir"
fi

# Symlink repo to .vim
target="$HOME/.vim"
if ! [[ -e $target ]]; then
  ln -s $VIMFILES_LOCAL_DIR $target
  ok_msg "$VIMFILES_LOCAL_DIR symlinked to $target"
else
  warn_msg "Symlink $target already exists"
fi

# Symlink *rc files
for file in 'vimrc' 'gvimrc'; do
  origin="$VIMFILES_LOCAL_DIR/$file"
  target="$HOME/.$file"

  if ! [[ -e $target ]]; then
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
vim -N -u $VIMFILES_LOCAL_DIR/plugins.vim +PluginInstall +qa
ok_msg 'Bundles installed'

# Uninstall script
# TODO
