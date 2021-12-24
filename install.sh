#!/bin/bash

uninstall () {
  rm -rf ~/.vimrc ~/.vim ~/.tmux.conf ~/.config/nvim/init.vim
}

install () {
  if [ -f ~/.vimrc ] || [ -f ~/.tmux.conf ] || [ -f ~/.config/nvim/init.vim ]; then
    echo 'Config is exist!'
    exit
  else
    ROOT_PATH=$(dirname $(readlink -e $0))
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
