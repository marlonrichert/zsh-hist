() {
  emulate -LR zsh -o noshortloops -o warncreateglobal -o extendedglob -o rcquotes

  typeset -gU FPATH fpath=( ${${(%):-%x}:A:h}/function ${${(%):-%x}:A:h} $fpath )

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
