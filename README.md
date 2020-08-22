# `zsh-hist`
* Fix your previous command by [pressing <kbd>Undo</kbd>](#added-undo-functionality).
* Edit your history with the [`hist` command](#hist-command-syntax).

## Added `undo` functionality
On any new command line, you can now press `undo` to pop the last command from your
history into the line editor, letting you correct any mistakes you made before running it back.
Afterwards, the old command will no longer be found in your history.

Note: `zsh-hist` does not change your key bindings. By default, Zsh binds [`undo` to `^_`, `^Xu`,
and `^X^U` in emacs mode and to `u` in vi command mode](
http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#index-undo). To define your own
key binding, add a line like [`bindkey 'YOUR_KEY_CODE' undo`](
http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#index-bindkey) to your `~/.zshrc` file.

## `hist` command syntax
```
Usage:
  hist [options] <action> [selection]

Options (can be combined):
  -f  force:  do not ask for confirmation
  -s  silent: do not print anything

Actions (required; mutually exclusive):
  d  delete: remove from history
  e  edit:   remove from history, then modify & append as new
  f  fix:    remove from history, then load into buffer
  l  list:   look, but do not touch
  r  reload: re-initialize local history from file
  u  undo:   roll back to before last change in same session

Selection (required for some actions; mutually exclusive):
  empty             most recent entry
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
