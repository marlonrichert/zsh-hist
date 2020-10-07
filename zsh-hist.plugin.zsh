#!/bin/zsh
() {
  emulate -L zsh -o extendedglob -o rcquotes -o noshortloops -o warncreateglobal

  local fdir=${${(%):-%x}:A:h}
  typeset -gU FPATH fpath=( $fdir/function $fdir $fpath )

  autoload -Uz hist

  autoload -Uz .hist.push-line.widget
  zle -N push-line .hist.push-line.widget
  zle -N push-input .hist.push-line.widget
  zle -N push-line-or-edit .hist.push-line.widget

  autoload -Uz .hist.get-line.widget
  zle -N get-line .hist.get-line.widget

  autoload -Uz .hist.undo.widget
  zle -N undo .hist.undo.widget
}
