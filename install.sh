#!/usr/bin/env bash
# Bootstrap. Depends on nothing but bash and coreutils -- the Command Line
# Tools that `git clone` already required to get you here.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${DEST:-$HOME}"
XDG="${XDG:-$DEST/.config}"

# Explicit manifest, deliberately not a glob: a new file in this repo should
# not silently become a new dotfile in $HOME. nvim is XDG, the rest are ~/.<name>.
LINKS=(
  "gitconfig:$DEST/.gitconfig"
  "gitignore:$DEST/.gitignore"
  "starship.toml:$DEST/.starship.toml"
  "tmux.conf:$DEST/.tmux.conf"
  "zshrc:$DEST/.zshrc"
  "nvim:$XDG/nvim"
)

DRY_RUN=0

say() { printf '  %-9s %s\n' "$1" "$2"; }
run() { [ "$DRY_RUN" -eq 1 ] && return 0; "$@"; }

usage() {
  cat <<'USAGE'
usage: ./install.sh [--dry-run] <command>

  install    link everything, skipping anything already in the way
  force      link everything, replacing whatever is in the way
  unlink     remove only the symlinks pointing back here
  deps       install the tools these configs assume
  list       show what install would manage
USAGE
}

# Split "src:dst" without a subshell. Paths here never contain a colon.
each_link() {
  local entry src dst
  for entry in "${LINKS[@]}"; do
    src="$DOTFILES/${entry%%:*}"
    dst="${entry#*:}"
    "$1" "$src" "$dst"
  done
}

link_one() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    say ok "$dst"
  elif [ -e "$dst" ] || [ -L "$dst" ]; then
    say EXISTS "$dst  (./install.sh force to replace)"
  else
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
    say linked "$dst"
  fi
}

force_one() {
  local src="$1" dst="$2"
  # An empty dst would make the rm below eat a parent directory.
  [ -n "$src" ] && [ -n "$dst" ] || return 0
  run mkdir -p "$(dirname "$dst")"
  run rm -rf -- "$dst"
  run ln -s "$src" "$dst"
  say linked "$dst"
}

# Only ever removes a symlink we own, never a real file someone put there.
unlink_one() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    run rm -f -- "$dst"
    say unlinked "$dst"
  fi
}

list_one() { printf '  %s -> %s\n' "$1" "$2"; }

deps() {
  run brew install neovim starship tmux the_silver_searcher \
      zsh-autosuggestions zsh-syntax-highlighting zsh-completions
  # typescript pinned to 5: TS 7 is the Go rewrite and ships no tsserver.js,
  # which typescript-language-server needs to start at all.
  run npm install -g typescript@5 typescript-language-server pyright
  run go install golang.org/x/tools/gopls@latest
}

main() {
  local cmd=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --dry-run|-n) DRY_RUN=1 ;;
      -h|--help)    usage; return 0 ;;
      *)            cmd="$1" ;;
    esac
    shift
  done

  [ "$DRY_RUN" -eq 1 ] && echo "(dry run -- nothing will change)"

  case "$cmd" in
    install) each_link link_one   ;;
    force)   each_link force_one  ;;
    unlink)  each_link unlink_one ;;
    list)    each_link list_one   ;;
    deps)    deps                 ;;
    ""|help) usage                ;;
    *)       echo "unknown command: $cmd" >&2; usage >&2; return 2 ;;
  esac
}

main "$@"
