# `zsh-hist`
* Fix your previous command by [pressing <kbd>Undo</kbd>](#added-undo-functionality).
* Edit your history with the [`hist` command](#command-line-syntax).

## Added Undo functionality
On any new command line, you can now press <kbd>Undo</kbd> to pop the last command from your
history into the line editor, letting you correct any mistakes you made before running it back.
Afterwards, the old command will no longer be found.

`zsh-hist` does not change keybindings. By default zsh binds `undo` to `^_`, `^Xu`, and `^X^U`
in emacs mode and to `u` in vi command mode. For a custom keybinding, add a line like
`bindkey 'YOUR_KEY_CODE' undo` to your `.zshrc`.

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
  e  edit:   remove from history, then modify & append as new
  f  fix:    remove from history, then load into buffer
  l  list:   look, but do not touch
  r  reload: re-initialize entire history from file
  u  undo:   roll back to before last change in same session

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
