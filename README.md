## neovim custom configuration

### LSPs configured
- tsserver
- gopls
- rust_analyser

### Quick installation
#### linux/docker-container
```sh 
curl -fsSL https://raw.githubusercontent.com/sanathsharma/neovim-config/main/setup/linux-install.sh > setup.sh
chmod +x setup.sh
./setup.sh
rm setup.sh
```

Run `<C-space> I` from within a tmux sesson to install all tmux plugins

### Upgrade
```sh 
curl -fsSL https://raw.githubusercontent.com/sanathsharma/neovim-config/main/setup/linux-upgrade-nvim.sh > setup.sh
chmod +x setup.sh
./setup.sh
rm setup.sh
```

### Rust, rust analyzer installation
install stable toolchain
```sh
rustup toolchain install stable
```
```sh
rustup component add rust-analyzer
```
This makes neovim use the same rust-analyzer verison as the compiler, avoiding editor not giving errors or giving unnecessary errors for example

-- lines from https://vi.stackexchange.com/questions/43681/simplest-setup-for-nvim-and-rust-and-system-rust-analyzer

```
You can confirm if your setup is using your system LSP via :checkhealth rustaceanvim after opening a Rust file:

Checking external dependencies
- OK rust-analyzer: found rust-analyzer 1.75.0 (82e1608 2023-12-21)
If instead you had accidentally installed Mason's rust-analyzer, this check would say something like

- OK rust-analyzer: found rust-analyzer 0.3.1799-standalone
In that event you could remove the Mason version with :MasonUninstall rust-analyzer.
```

### Commands and keymaps

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
- `:split` - split horizontal window
- `:vsplit` - split vertical window
- `<C-w> *` - window options including resizing
- `>>` - normal mode; indent code right
- `<<` - normal mode; indent code left
- `<` - visual mode; indent code left
- `>`- visual mode; indent code left
- `:%s/<old-name>/<new-name>/g` - rename something in a file with a new value
- `.` - repeat
- `:<cmd> | only` - `:only` is the command that will make the current window the only window visible.
- `:so` - re source nvim config
- `H` - go to top line, in visible range
- `L` - go to bottom line, in visible range

