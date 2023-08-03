#!/bin/bash

ROOT_PATH=$(dirname $(readlink -e $0))
SOURCE_COMMAND="[ -f $ROOT_PATH/.zshrc ] && source $ROOT_PATH/.zshrc"

uninstall () {
  rm -rf \
    ~/.tmux.conf \
    ~/.config/nvim \
    ~/.vifm/vifmrc \
    ~/.profile

  if grep -q "$SOURCE_COMMAND" ~/.zshrc; then
    grep -v "$SOURCE_COMMAND" ~/.zshrc > ~/tmp && mv ~/tmp ~/.zshrc
  fi
}

install () {
  if [ -f ~/.tmux.conf ] \
    || [ -f ~/.config/nvim ] \
    || [-f ~/.vifm/vifmrc]
  ; then
    echo 'Config is exist!'
    exit
  else
    if ! grep -q "$SOURCE_COMMAND" ~/.zshrc; then
      echo "$SOURCE_COMMAND" >> ~/.zshrc
    fi

    ln -s "$ROOT_PATH/.tmux.conf" ~/.tmux.conf

    mkdir -p ~/.vifm
    ln -s "$ROOT_PATH/vifm/vifmrc" ~/.vifm/vifmrc

    ln -s "$ROOT_PATH/nvim" ~/.config/nvim

    ln -s "$ROOT_PATH/.profile" ~/.profile

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
