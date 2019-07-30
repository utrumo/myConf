#!/bin/bash

uninstall () {
  rm -rf ~/.vimrc ~/.vim ~/.tmux.conf
}

install () {
  if [ -f ~/.vimrc ] || [ -f ~/.tmux.conf ]; then
    echo 'Config is exist!'
    exit
  else
    ROOT_PATH=$(dirname $(readlink -e $0))
    ln -s "$ROOT_PATH/.vimrc" ~/.vimrc
    ln -s "$ROOT_PATH/.tmux.conf" ~/.tmux.conf
    vim +PlugInstall +qall
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
