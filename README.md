# `zsh-hist`
Edit your Zsh history, without ever leaving the command line.

## Installation
 1. `git clone` this repo.
 1. Add the following to your `~/.zshrc` file:
    ```zsh
    source path/to/zsh-hist.plugin.zsh
    ```

To update, `cd` into your clone and `git pull`.

## Uniform code formatting
Whenever you finish your command line, `zsh-hist` will automatically format it for you, before it is saved to history.
You can also retroactively format your history with [`hist n`](#hist-command-syntax).

### Notes on code formatting
* For the formatting to be preserved completely when the command is saved history, you need to
  `unsetopt HIST_REDUCE_BLANKS` in your `.zshrc` file.  Otherwise, most of the indentation will get lost.
* Formatting the code can disable certain crazy uses of global aliases.  For example, since the formatting turns most
  `;`s into newlines, declaring `;` as a global alias will most of the time simply not have any effect.  Since this is
  not something a normal person would want to do, most users don't need to worry about this.  However, if you are a
  purist and want that the formatting can _never_ change the way Zsh works, then please enable the [automatic alias
  expansion](#optional-automatic-alias-expansion) feature below.
* To disable this feature, add the following to your `.zshrc` file:
  ```zsh
  zstyle ':hist:*' auto-format no
  ```

## Automatic alias expansion (Optional)
`zsh-hist` can automatically expand your aliases before each command line is saved to history.  This is disabled by
default, but to enable it, add the following to your `.zshrc` file:
```zsh
zstyle ':hist:*' expand-aliases yes
```

## Added <kbd>Undo</kbd> functionality
On any new command line, you can now press <kbd>Undo</kbd> to pop the last command from your history into the line
editor, letting you correct any mistakes you made, before running it back.  Afterwards, the old, faulty command will be
gone from your history and only the new, corrected one remains.

Additionally, if you make a typo and end up on the secondary prompt, you can now press <kbd>Undo</kbd> to return to the
primary prompt.

## Push lines to history
When you press <kbd>⌃</kbd><kbd>Q</kbd>, your line is now written to history (without being executed) instead of to the
buffer stack.

This has the following benefits:
* A pushed line does not automatically get popped back into your line editor.
* Pushed lines persist as long as they remain in your history and can be shared between multiple sessions.
* Pushed lines can be accessed using conventional history search mechanisms.

Pressing <kbd>⌃</kbd><kbd>Q</kbd> on the secondary prompt will return you to the primary prompt.

## `hist` command syntax
```
Usage
  hist [<option>...] compress <delta>
  hist [<option>...] {reload|undo}
  hist [<option>...] <command> <selection> ...

Return value
  $reply  an associative array of history index -> entry tuples

Options
  -f  force: never ask for confirmation
  -i  interactive: always ask for confirmation
  -q  quiet: do not print anything
  -s  silent: same as quiet
By default, hist asks for confirmation only when operating on multiple history
entries.

Commands (can be shortened to first letter):
  compress   delete each entry that differs <delta> chars or less from the next
  delete     remove from history
  edit       delete, then modify & append as new
  fix        delete + get
  get        load into buffer
  list       look, but do not touch
  normalize  delete, then auto-format & append as new
  reload     re-initialize local history from file
  undo       roll back to before last command in same session

Selections (for commands other than compress, reload or undo):
  negative int  offset from end of history
  positive int  index from beginning of history
  pattern       all matching entries

Examples
  hist f -1         # Fix last entry (cut from history; paste into command line)
  hist n {1..9}     # Normalize (uniformly format) a range of history items
  hist d $'*(\n|;)' # Delete all entries ending in newline or semicolon
```

## Author
© 2020 [Marlon Richert](https://github.com/marlonrichert)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
