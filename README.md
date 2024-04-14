## neovim custom configuration

setup includes LSP support for ts, go and rust

## commands and keymaps

- `:<linenumber>` - take cursor to specified line number
- `{` - go to previous empty line
- `}` - go to next empty line
- `zf` - create a manual fold
- `za` - toggle a fold
- `[c` - go to previous hunk
- `]c` - go to next hunk
- `:Telescope git_commits` - fuzzy search git commits
- `:Telescope git_branches` - fuzzy search git branches
- `:Git` - git status
- `:Git mergetool` - open git mergetool
- `:Git difftool` - open git difftool
- `[d` - go to previous error diagnostics
- `]d` - go to next error diagnostics
- `:mkview` - write folds into a file
- `:loadview` - read folds into a file
- `:bd` - close all buffers
- `:bp` - switch to previous buffer
- `:bn` - switch to next buffer
- `:bufdo bd` - close all buffers (INFO: will execute the following command for all buffers)
- `gg` - go to top of the file
- `G` - go to bottom of the file

