#!/bin/bash

status_msg() {
  printf "\033[1;34m:\033[0m\033[1;37m %s\033[0m\n" "$1"
}

error_msg() {
  printf "\033[1;31m\xe2\x9c\x98 %s\033[0m\n" "$1"
}

ok_msg() {
  printf "\033[1;32m\xe2\x9c\x93 %s\033[0m\n" "$1"
}

warn_msg() {
  printf "\033[1;33m\xe2\x96\xa0 %s\033[0m\n" "$1"
}

VIMFILES_GIT_REPO="https://github.com/obxhdx/vimfiles"
VIMFILES_HOME_DIR="$HOME/.vim"

# Clone vimfiles repo
if [[ -d $VIMFILES_HOME_DIR ]]; then
  warn_msg "Folder $VIMFILES_HOME_DIR already exists. Exiting..."
  exit
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
    ok_msg "File $origin symlinked to $target"
  else
    warn_msg "Symlink $target already exists"
  fi;
done;

# Install plugins
vim -N -u "$VIMFILES_HOME_DIR/plugs.vim" +PlugInstall +qa
ok_msg 'Plugins installed'

# Uninstall script
# TODO
