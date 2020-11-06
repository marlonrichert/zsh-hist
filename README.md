# `zsh-hist`
Edit your history in Zsh, without ever leaving the command line.

* [Installation](#installation)
* Features:
  * Fix your previous command by [pressing <kbd>undo</kbd>](#added-undo-functionality).
  * Push & get lines to/from history with [<kbd>push-line</kbd> and
    <kbd>get-line</kbd>](#push--get-lines-tofrom-history).
  * Edit your history with the [`hist` command](#hist-command-syntax).
* Don't know how to change your key bindings? Please [read these notes](#note-about-key-bindings).
* [Author](#author)
* [License](#license)

## Installation
 1. `git clone` this repo.
 1. Add the following to your `~/.zshrc` file:
    ```zsh
    source path/to/zsh-hist.plugin.zsh
    ```

To update, `cd` into your clone and `git pull`.

## Added Undo functionality
On any new command line, you can now press <kbd>undo</kbd> to pop the last command from your
history into the line editor, letting you correct any mistakes you made, before running it back.
Afterwards, the old, faulty command will be gone from your history.

## Push & Get lines to/from history
When you press <kbd>push-line</kbd>, <kbd>push-input</kbd> or <kbd>push-line-or-edit</kbd>, your
line is now written to history (without being executed) instead of to the buffer stack.

This has the following benefits:
* A pushed line does not automatically get popped back into your line editor. You can instead get
  it back at your own convenience with <kbd>get-line</kbd>, at which point it is removed from
  history. (Executing the line will of course add it back to your history, but at this point, it
  will not count as pushed anymore.)
* Pushed lines persist as long as they remain in your history and can be shared between multiple
  sessions.
* Pushed lines can be accessed using conventional history search mechanisms.

To get a list of all pushed lines in your history, just type `hist l`.

## `hist` command syntax
```
Usage:
  hist [options] <action> [selection]  ->  $reply

Return value:
  reply  an associative array of history (index, entry) tuples

Options (can be combined):
  -f  force:       never ask for confirmation
  -i  interactive: always ask for confirmation
  -s  silent:      do not print anything
By default, hist asks for confirmation only when operating on multiple history entries.

Actions (required; mutually exclusive):
  d  delete: remove from history
  e  edit:   remove from history, then modify & append as new
  f  fix:    remove from history, then load into buffer
  g  get:    load into buffer
  l  list:   look, but do not touch
  r  reload: re-initialize local history from file
  u  undo:   roll back to before last action in same session

Selection (required for some actions; mutually exclusive):
  empty or 0        pushed lines
  positive integer  index from beginning of history
  negative integer  offset from end of history
  string            pattern to match; can select multiple entries


--Examples--

Delete all history items starting with `fc `:
  hist d 'fc *'

List all history items starting with `git ` and ending with `lease`:
  hist l 'git *lease'

Fix the last history item: Cut from history, paste into command line.
  hist f -1
```

## Note about key bindings
`zsh-hist` does not change your key bindings. To use the keyboard commands (a.k.a "widgets") that
`zsh-hist` enhances, you will need to know to which key strokes they are bound. Not all widgets
discussed here are bound by default.
* Type `bindkey` to see your current key bindings.
* To add a new new keybinding or override an existing one, add lines like the following to your
  `~/.zshrc` file, where `^` means <kbd>Ctrl</kbd> and `^[` means <kbd>Alt</kbd> (depending on your
  terminal):
  ```sh
  bindkey "^_" undo
  bindkey "^[q" push-line-or-edit
  bindkey "^[g" get-line
  ```
* See the [Zsh Line Editor
  documentation](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html) for more info.

## Author
© 2020 [Marlon Richert](https://github.com/marlonrichert)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
