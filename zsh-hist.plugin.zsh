#!/bin/zsh
() {
  emulate -L zsh -o extendedglob -o rcquotes -o noshortloops -o warncreateglobal

  local dir=${${(%):-%x}:A:h}
  local fdir=$dir/functions
  export -U fpath=( $fdir $dir $fpath )

  # Work around https://github.com/zdharma/zinit/issues/441
  builtin autoload -Uz $fdir/hist $fdir/.hist.*~*.zwc

  zle -N push-line .hist.push-line.widget
  zle -N push-input .hist.push-line.widget
  zle -N push-line-or-edit .hist.push-line.widget

  zle -N get-line .hist.get-line.widget

  zle -N undo .hist.undo.widget

  autoload -Uz add-zsh-hook
  :hist:precmd() {
    local 0=${(%):-%N}
    add-zsh-hook -d precmd $0
    unfunction $0

    autoload -Uz add-zle-hook-widget
    add-zle-hook-widget line-finish .hist.format.hook
  }
  add-zsh-hook precmd :hist:precmd
}
