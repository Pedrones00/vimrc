# Vim Keybindings

> **Leader:** `<Space>`

## Custom Keybindings

| Key         | Action                           |
| ----------- | -------------------------------- |
| `<Leader>e` | Open file explorer               |
| `<Leader>w` | Save file                        |
| `<Leader>q` | Quit Vim                         |
| `<Leader>h` | Move to left window              |
| `<Leader>j` | Move to lower window             |
| `<Leader>k` | Move to upper window             |
| `<Leader>l` | Move to right window             |
| `<Leader>=` | Equalize window sizes            |
| `<Leader>r` | Set window width to 50 columns   |
| `<Leader>z` | Toggle line wrapping             |
| `<Leader>t` | Open terminal                    |
| `<Leader>f` | Search words across the project  |
| `<Leader>R` | Replace text in the current file |
| `<C-p>`     | Find files                       |
| `<C-Up>`    | Increase window height           |
| `<C-Down>`  | Decrease window height           |
| `<C-Left>`  | Decrease window width            |
| `<C-Right>` | Increase window width            |

---

## Netrw File Explorer

| Key       | Action                        |
| --------- | ----------------------------- |
| `<Enter>` | Open file or directory        |
| `v`       | Open file in vertical split   |
| `s`       | Open file in horizontal split |
| `%`       | Create a new file             |
| `d`       | Create a new directory        |
| `R`       | Rename file or directory      |
| `D`       | Delete file or directory      |
| `q`       | Close file explorer           |

---

## Vim Navigation

| Key         | Action                          |
| ----------- | ------------------------------- |
| `i`         | Insert before cursor            |
| `a`         | Insert after cursor             |
| `I`         | Insert at beginning of line     |
| `A`         | Insert at end of line           |
| `o`         | Create new line below           |
| `O`         | Create new line above           |
| `v`         | Visual mode                     |
| `V`         | Visual line mode                |
| `<C-v>`     | Visual block mode               |
| `gg`        | Go to beginning of file         |
| `G`         | Go to end of file               |
| `0`         | Go to beginning of line         |
| `^`         | Go to first non-blank character |
| `$`         | Go to end of line               |
| `w`         | Move to next word               |
| `b`         | Move to previous word           |
| `e`         | Move to end of word             |
| `[number]j` | Move down N lines               |
| `[number]k` | Move up N lines                 |

---

## Vim Editing

| Key         | Action                          |
| ----------- | ------------------------------- |
| `yy`        | Yank current line               |
| `Y`         | Yank current line               |
| `y{motion}` | Yank text using a motion        |
| `dd`        | Delete current line             |
| `d{motion}` | Delete text using a motion      |
| `p`         | Paste after cursor              |
| `P`         | Paste before cursor             |
| `u`         | Undo                            |
| `<C-r>`     | Redo                            |
| `x`         | Delete character under cursor   |
| `r{char}`   | Replace character               |
| `J`         | Join current line with the next |
| `.`         | Repeat last change              |
| `>>`        | Indent line                     |
| `<<`        | Unindent line                   |
| `ci"`       | Change inside double quotes     |
| `ci'`       | Change inside single quotes     |
| `ci(`       | Change inside parentheses       |
| `ci[`       | Change inside brackets          |
| `ci{`       | Change inside braces            |
| `cit`       | Change inside HTML/XML tag      |

---

## Search

| Key          | Action                            |
| ------------ | --------------------------------- |
| `/{pattern}` | Search forward                    |
| `?{pattern}` | Search backward                   |
| `n`          | Go to next match                  |
| `N`          | Go to previous match              |
| `:noh`       | Clear search highlighting         |
| `<C-p>`      | Find files *(custom mapping)*     |
| `<Leader>f`  | Search project *(custom mapping)* |

---

## Buffers

| Command       | Action                |
| ------------- | --------------------- |
| `:ls`         | List buffers          |
| `:b {number}` | Open buffer by number |
| `:bn`         | Go to next buffer     |
| `:bp`         | Go to previous buffer |
| `:bd`         | Delete current buffer |

---

## Windows

| Command  | Action                  |
| -------- | ----------------------- |
| `<C-w>h` | Move to left window     |
| `<C-w>j` | Move to lower window    |
| `<C-w>k` | Move to upper window    |
| `<C-w>l` | Move to right window    |
| `<C-w>w` | Cycle through windows   |
| `<C-w>p` | Go to previous window   |
| `<C-w>s` | Create horizontal split |
| `<C-w>v` | Create vertical split   |
| `<C-w>=` | Equalize window sizes   |
| `<C-w>+` | Increase window height  |
| `<C-w>-` | Decrease window height  |
| `<C-w>>` | Increase window width   |
| `<C-w><` | Decrease window width   |

---

## Files

| Command | Action              |
| ------- | ------------------- |
| `:w`    | Save file           |
| `:q`    | Quit                |
| `:wq`   | Save and quit       |
| `:q!`   | Quit without saving |
| `:x`    | Save and quit       |
| `:wa`   | Save all files      |
| `:qa`   | Quit all windows    |
| `:wqa`  | Save all and quit   |

---

## Insert Mode Completion

| Key     | Action              |
| ------- | ------------------- |
| `<C-n>` | Next completion     |
| `<C-p>` | Previous completion |

> `<C-p>` is mapped to **Find Files** in Normal mode, but remains the native completion command in Insert mode.
