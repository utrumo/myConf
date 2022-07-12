export EDITOR=nvim

ROOT_PATH=$(dirname $(readlink -e $0))

if [ -d "$HOME/.npm-global/bin" ] ; then
    PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

[ -f "$HOME/.fzf.zsh" ] && source ~/.fzf.zsh
[ -f "$ROOT_PATH/.fzf.zsh" ] && source ~/myConf/.fzf.zsh
[ -f "$ROOT_PATH/onChangeCopy.sh" ] && source "$ROOT_PATH/onChangeCopy.sh"
