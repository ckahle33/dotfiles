# dotfiles

    make install

Symlinks everything into place — `zshrc` → `~/.zshrc`, and `nvim/` →
`~/.config/nvim`. Existing files are never clobbered; `make force` replaces
them, `make unlink` backs the whole thing out.

    make            list the targets
    make install    link, skipping anything already in the way
    make force      link, replacing whatever is in the way
    make unlink     remove only the symlinks pointing back here
    make deps       install the tools these configs assume
    make list       show what install would manage

Plain `sh` and the `make` macOS ships. No runtime to install first — the
Command Line Tools that `git clone` already needed are the only dependency.

## What's here

| file            | notes |
|-----------------|-------|
| `nvim/init.lua` | **Zero plugins.** One file, no manager, no lockfile, nothing to update. |
| `zshrc`         | No framework. Prompt is starship; autosuggestions + syntax highlighting from brew. |
| `starship.toml` | Reached via `$STARSHIP_CONFIG` (set in `zshrc`), since starship otherwise wants `~/.config/`. |
| `tmux.conf`     | Prefix is `C-a`. Tuned for watching several agent panes at once. |
| `gitconfig`     | Aliases `st`/`ci`/`co` etc. |
| `gitignore`     | Global ignore — machine and editor noise only. |

## The no-plugin bet

Neovim 0.11+ absorbed most of what the old vim plugin list was doing:

| was                        | now |
|----------------------------|-----|
| `vim-commentary`           | built-in `gc` / `gcc` (0.10+) |
| `vim-go`, completion       | built-in LSP + `vim.lsp.completion` (0.11+) |
| `vim-airline`              | native `statusline`, one line |
| `nerdTree`                 | `:Lexplore` (netrw), `<leader>d` |
| `fzf` / `ctrlp`            | `:find` with `path+=**`, `<leader>p` |
| `gundo`                    | `undofile` (persistent undo) |
| `vim-easy-align`           | visual select + `<leader>a` → `:!column -t` |
| `FastFold`, syntax plugins | built-in filetype + treesitter |

Knowingly given up: `fugitive` (git runs in the terminal), gutter git signs,
and `vim-surround`. If any of those turn out to matter more than the zero
maintenance, that is the moment to reconsider — not before.

Language servers are ordinary binaries, not plugins: `gopls`, `ts_ls`,
`pyright`. `make deps` installs them.

No Nerd Font needed — `starship.toml` deliberately uses only characters that
plain Monaco has.
