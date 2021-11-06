# `zsh-hist`
Edit your Zsh history, without ever leaving the command line.

* [Installation](#installation)
* Features:
  * Eliminate more duplicates by applying [uniform code formatting](#uniform-code-formatting).
  * (Optional) [Automatically expand aliases](#optional-automatic-alias-expansion) before each
    command line is saved to history.
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

## Uniform code formatting
Whenever you finish your command line, `zsh-hist` will automatically format it for you, before it
is saved to history. You can also retroactively format your history with
[`hist n`](#hist-command-syntax).

**Notes:**
* For the formatting to be preserved completely when the command is saved history, you need to
  `unsetopt HIST_REDUCE_BLANKS` in your `.zshrc` file. Otherwise, most of the indentation will get
  lost.
* Formatting the code can disable certain crazy uses of global aliases. For example, since the
  formatting turns most `;`s into newlines, declaring `;` as a global alias will most of the time
  simply not have any effect. Since this is not something a normal person would want to do, most
  users don't need to worry about this. However, if you are a purist and want that the formatting
  can _never_ change the way Zsh works, then please enable the [automatic alias
  expansion](#optional-automatic-alias-expansion) feature below.

## (Optional) Automatic alias expansion
`zsh-hist` can automatically expand your aliases before each command line is saved to history.
This is disabled by default, but to enable it, add the following to your `.zshrc` file:
```zsh
zstyle ':hist:*' expand-aliases yes
```

## Added Undo functionality
On any new command line, you can now press <kbd>undo</kbd> to pop the last command from your
history into the line editor, letting you correct any mistakes you made, before running it back.
Afterwards, the old, faulty command will be gone from your history and only the new, corrected one
remains.

Additionally, if you make a typo and end up on the secondary prompt, you can now press
<kbd>undo</kbd> to return to the primary prompt.

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
  hist [<option> ...] <command> [<selection> ...] -> $reply

Return value:
  $reply  an associative array of history (index -> entry) tuples

Options:
  -f  force:       never ask for confirmation
  -i  interactive: always ask for confirmation
  -q  quiet:       do not print anything
  -s  silent:      same as quiet
By default, hist asks for confirmation only when operating on multiple history
entries.

Commands:
  d  delete:     remove from history
  e  edit:       remove from history, then modify & append as new
  f  fix:        remove from history, then load into buffer
  g  get:        load into buffer
  l  list:       look, but do not touch
  n  normalize:  remove from history, then format & append as new
  r  reload:     re-initialize local history from file
  u  undo:       roll back to before last action in same session

Selection (ignored for 'r' and 'u'):
  empty         pushed lines
  positive int  index from beginning of history
  negative int  offset from end of history
  pattern       all matching entries

--Examples--
Fix (cut from history; paste into command line) the last history item:
  hist f -1
Normalize (uniformly format) a range of history items:
  hist n {1..9}
Delete all history items ending with a newline or a semicolon:
  hist d $'*(\n|;)'
List all command lines you've saved to history with the `push-line` widget
  hist l
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
