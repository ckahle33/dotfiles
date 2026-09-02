# ─────────────────────────────────────────────────────────────
# PATH  (brew first, then dedupe -- $path is tied to $PATH)
# ─────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

export GOPATH=$HOME/src/go

path=(
  $HOME/.local/bin
  $GOPATH/bin           # go install drops binaries here (gopls lives here)
  /Applications/Postgres.app/Contents/Versions/latest/bin
  $path
)
typeset -U path        # drop duplicates; also kills the trailing-":" cwd entry

export EDITOR=nvim

# ─────────────────────────────────────────────────────────────
# HISTORY
# ─────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # all panes see the same history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE      # leading space keeps a command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY            # expand !! for review instead of running it
setopt EXTENDED_HISTORY

# ─────────────────────────────────────────────────────────────
# OPTIONS
# ─────────────────────────────────────────────────────────────
setopt AUTO_CD                # "src" == "cd src"
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt INTERACTIVE_COMMENTS   # allow # comments when typing
setopt NO_BEEP

# ─────────────────────────────────────────────────────────────
# COMPLETION
# ─────────────────────────────────────────────────────────────
fpath=(/opt/homebrew/share/zsh-completions $fpath)
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' group-name ''
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# ─────────────────────────────────────────────────────────────
# ALIASES
# oh-my-zsh supplied .. and ... -- they are ours now.
# ─────────────────────────────────────────────────────────────
alias ls='ls -lah'
alias vim='nvim'
alias vi='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ─────────────────────────────────────────────────────────────
# KEYS
# ─────────────────────────────────────────────────────────────
bindkey -e
bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→
bindkey "^[[1;9D" beginning-of-line # ⌘←
bindkey "^[[1;9C" end-of-line       # ⌘→

# ─────────────────────────────────────────────────────────────
# PLUGINS  (syntax-highlighting must be sourced last)
# ─────────────────────────────────────────────────────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ─────────────────────────────────────────────────────────────
# PROMPT
# ─────────────────────────────────────────────────────────────
export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"
