#!/bin/zsh
zstyle ':hist:*' load-hooks true
unsetopt flowcontrol

zsh-hist() {
  emulate -L zsh -o extendedglob -o rcquotes -o noshortloops -o warncreateglobal

  local dir=${${(%):-%x}:P:h}
  local fdir=$dir/functions
  typeset -gU FPATH fpath=( $dir $fpath )

  # Work around https://github.com/zdharma/zinit/issues/441
  builtin autoload -Uz $fdir/hist $fdir/.hist.*~*.zwc

  bindkey -M 'emacs' '^Q' push-history
  bindkey -M 'viins' '^Q' push-history
  bindkey -M 'vicmd' '^Q' push-history
  zle -N push-history .hist.push-history.widget

  zle -N undo .hist.undo.widget

  autoload -Uz add-zsh-hook
  :hist:precmd() {
    local 0=${(%):-%N}
    add-zsh-hook -d precmd $0
    unfunction $0

    autoload -Uz add-zle-hook-widget
    if zstyle -T ':hist:*' load-hooks; then
        add-zle-hook-widget line-init .hist.format.hook
        add-zle-hook-widget line-finish .hist.format.hook
    fi

  }
  add-zsh-hook precmd :hist:precmd
}

{
  zsh-hist "$@"
} always {
  unfunction zsh-hist
}
