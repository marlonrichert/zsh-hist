# `zsh-hist`
* Fix your previous command by [pressing <kbd>Undo</kbd>](#added-undo-functionality).
* Edit your history with the [`hist` command](#command-line-syntax).

## Added Undo functionality
On any new command line, you can now press <kbd>Undo</kbd> to pop the last command from your
history into the line editor, letting you correct any mistakes you made before running it back.
Afterwards, the old command will no longer be found.

(Check with `bindkey` to see which keyboard shortcut is bound to `undo`. `zsh-hist` does not change
that.)

## Command line syntax
```sh
Usage:
  hist [options] <action> [selection]

Options (can be combined):
  -i  interactive: ask for confirmation
  -s  silent:      do not print anything
  -v  verbose:     print all the things

Actions (required; mutually exclusive):
  d  delete: remove from history
  e  edit:   remove from history, modify & append as new
  f  fix:    remove from history & load into buffer
  l  list:   look, but do not touch
  r  reload: re-initialize entire history from file
  u  undo:   roll back to before last change

Selection (required for some actions; mutually exclusive):
  empty             last event
  positive integer  index from beginning of history
  negative integer  offset from end of history
  simple string     prefix to match (selects one)
  glob expression   pattern to match (selects multiple)
```

## Author
© 2020 [Marlon Richert](https://github.com/marlonrichert)

## License
This project is licensed under the MIT License. See the
[LICENSE](/marlonrichert/zsh-hist/LICENSE) file for details.
