#!/bin/bash

ROOT_PATH=$(dirname $(readlink -e $0))
SOURCE_COMMAND="[ -f $ROOT_PATH/.zshrc ] && source $ROOT_PATH/.zshrc"

uninstall () {
  rm -rf \
    ~/.vimrc \
    ~/.vim \
    ~/.tmux.conf \
    ~/.config/nvim

  if grep -q "$SOURCE_COMMAND" ~/.zshrc; then
    grep -v "$SOURCE_COMMAND" ~/.zshrc > ~/tmp && mv ~/tmp ~/.zshrc
  fi
}

install () {
  if [ -f ~/.vimrc ] \
    || [ -f ~/.tmux.conf ] \
    || [ -f ~/.config/nvim/init.vim ] \
    || [ -f ~/.config/nvim/coc-settings.json ] \
  ; then
    echo 'Config is exist!'
    exit
  else
    if ! grep -q "$SOURCE_COMMAND" ~/.zshrc; then
      echo "$SOURCE_COMMAND" >> ~/.zshrc
    fi

    ln -s "$ROOT_PATH/.vimrc" ~/.vimrc
    ln -s "$ROOT_PATH/.tmux.conf" ~/.tmux.conf
    mkdir -p ~/.config/nvim
    ln -s "$ROOT_PATH/init.vim" ~/.config/nvim/init.vim
    ln -s "$ROOT_PATH/coc-settings.json" ~/.config/nvim/coc-settings.json
    nvim +PlugInstall +qall
    tmux
  fi
}

force () {
  uninstall
  install
}

case $1 in
  uninstall)
    uninstall
    echo 'uninstalled'
  ;;

  force)
    force
    echo 'installation forced'
  ;;

  *)
    install 
    echo 'installed'
  ;;
esac
