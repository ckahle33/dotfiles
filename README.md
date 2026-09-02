# dotfiles

    ./install.sh install

Symlinks the configs into place, leaving anything already there alone.

    ./install.sh install    link, skipping anything already in the way
    ./install.sh force      link, replacing whatever is in the way
    ./install.sh unlink     remove only the symlinks pointing back here
    ./install.sh deps       install the tools these configs assume
    ./install.sh list       show what install would manage

`--dry-run` prints what any of those would do without touching the disk.
Plain bash, no runtime to install first — the Command Line Tools that
`git clone` already needed are the only dependency.

## What's here

| file            | links to           | notes |
|-----------------|--------------------|-------|
| `nvim/init.lua` | `~/.config/nvim`   | Zero plugins. Core LSP (`gopls`, `ts_ls`, `pyright`), built-in completion, `gc` commenting, `:Lexplore`, `:find`. |
| `zshrc`         | `~/.zshrc`         | No framework. Prompt is starship; autosuggestions + syntax highlighting from brew. |
| `starship.toml` | `~/.starship.toml` | Found via `$STARSHIP_CONFIG`, set in `zshrc`. Uses only characters plain Monaco has, so no Nerd Font is needed. |
| `tmux.conf`     | `~/.tmux.conf`     | Prefix is `C-a`, status bar on top. Tuned for watching several agent panes at once. |
| `gitconfig`     | `~/.gitconfig`     | Aliases `st`/`ci`/`co` etc. |
| `gitignore`     | `~/.gitignore`     | Global ignore — machine and editor noise only. |

That mapping is an explicit list in `install.sh`, not a glob, so adding a file
to this repo does not by itself turn it into a dotfile — add a row to `LINKS`.
`install` and `unlink` only ever touch symlinks that point back here; a real
file in the way is reported and left alone until you ask for `force`.

Language servers are ordinary binaries rather than plugins, so `deps` installs
them alongside neovim, starship, tmux and ag.
