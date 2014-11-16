#!/bin/bash

status_msg() {
  printf "\033[1;34m:\033[0m\033[1;37m %s\033[0m\n" "$1"
}

error_msg() {
  printf "\033[1;31m\xe2\x9c\x98 %s\033[0m\n" "$1"
}

ok_msg() {
  printf "\033[0;32m\xe2\x9c\x93 %s\033[0m\n" "$1"
}

warn_msg() {
  printf "\033[0;33m\xe2\x96\xa0 %s\033[0m\n" "$1"
}

VIMFILES_GIT_REPO="https://github.com/obxhdx/vimfiles"
VIMFILES_HOME_DIR="$HOME/.vim"

# Clone vimfiles repo
if [[ -d $VIMFILES_HOME_DIR ]]; then

  if [[ $(git config --get remote.origin.url) = $VIMFILES_GIT_REPO ]]; then
    ok_msg "Folder $VIMFILES_HOME_DIR is a copy of $VIMFILES_GIT_REPO"
  else
    warn_msg "Folder $VIMFILES_HOME_DIR is not a copy of $VIMFILES_GIT_REPO"
  fi

else
  git clone "$VIMFILES_GIT_REPO" "$VIMFILES_HOME_DIR"
  ok_msg "Repo $VIMFILES_GIT_REPO cloned into $VIMFILES_HOME_DIR"
fi

# Symlink vimrc and gvimrc
for file in 'vimrc' 'gvimrc'; do
  origin="$VIMFILES_HOME_DIR/$file"
  target="$HOME/.$file"

  if ! [[ -e $target ]]; then
    ln -s "$origin" "$target"
  fi

  if [[ $(readlink $target) = $origin ]]; then
    ok_msg "Symlink $target points to $origin"
  else
    warn_msg "Symlink $target does not point to $origin"
  fi
done;

# Create backup,swap dirs
mkdir -p $VIMFILES_HOME_DIR/tmp/{backup,swap}

# Install Vim-Plug
if ! [[ -f "$VIMFILES_HOME_DIR/autoload/plug.vim" ]]; then
  warn_msg 'Vim-Plug is not installed... installing now...'
  mkdir -p "$VIMFILES_HOME_DIR/autoload"
  curl -fLS --progress -o "$VIMFILES_HOME_DIR/autoload/plug.vim" 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Install plugins
vim -N -u "$VIMFILES_HOME_DIR/plugs.vim" +PlugInstall +qa
ok_msg 'All plugins installed'

# Uninstall script
# TODO
