() {
  emulate -LR zsh -o noshortloops -o warncreateglobal -o extendedglob -o rcquotes

  typeset -gU FPATH fpath=( ${${(%):-%x}:A:h}/function $fpath )
  autoload -Uz hist .hist.undo.widget
  zle -N undo .hist.undo.widget
}
