PS1="%F{green}%n%f@%F{magenta}%m%f $PS1"

export CHROOT=$HOME/chroot
export EDITOR=nvim

ROOT_PATH=$(dirname $(readlink -e $0))

if [ -d "$HOME/.npm-global/bin" ] ; then
    PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

# [ -f "$HOME/.fzf.zsh" ] && source ~/.fzf.zsh
# [ -f "$ROOT_PATH/.fzf.zsh" ] && source ~/myConf/.fzf.zsh
[ -f "$ROOT_PATH/onChangeCopy.sh" ] && source "$ROOT_PATH/onChangeCopy.sh"

if [ -f "/usr/bin/go" ] ; then
  export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
fi

[ -f "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -f "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"
