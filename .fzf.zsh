export FZF_DEFAULT_OPTS="
  --multi
  --height 40%
  --reverse
  --preview-window='right:wrap:hidden'
  --bind='\
f2:toggle-preview,\
f3:execute(bat -n {} || less -N {}),\
ctrl-u:half-page-up,\
ctrl-d:half-page-down,\
ctrl-a:select-all+accept,\
ctrl-y:execute(echo {+} | xsel -ib)\
'
  --preview '
    if [[ \$(file -bL --mime-type {}) = inode/directory ]] then
      echo \"{}\nis a directory\"
    elif [[ \$(file -bL --mime-encoding {}) = binary ]] then
      echo \"{}\nis a binary file\"
    else
      (bat -n --color always {} || cat {}) 2> /dev/null | head -100
    fi
  '
"
# start fzf in a split pane in tmux
export FZF_TMUX=1

# instead of using **<TAB> to trigger fuzzy completion use <CTRL-T>
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# configs for fdfind and find for fallback
useFDFind () {
  FIND_OPTIONS="--hidden --no-ignore --follow --exclude .git"
  # export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"--ansi"
  # FIND_OPTIONS+=" --color always"
  export FZF_DEFAULT_COMMAND="fdfind --type f --type l $FIND_OPTIONS"
  export FZF_CTRL_T_COMMAND="fdfind $FIND_OPTIONS"
  export FZF_ALT_C_COMMAND="fdfind --type d $FIND_OPTIONS"
}

fallbackToFind () {
  FIND_OPTIONS="-type d -name .git -prune"
  export FZF_DEFAULT_COMMAND="find $FIND_OPTIONS -o \( -type f -o -type l \) -print"
  export FZF_CTRL_T_COMMAND="find $FIND_OPTIONS -o -print"
  export FZF_ALT_C_COMMAND="find $FIND_OPTIONS -o -type d -print"
}

if hash fdfind 2>/dev/null; then
  useFDFind
else
  fallbackToFind
fi
