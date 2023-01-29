export ZSH=~/.oh-my-zsh

# theming
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# only if spaceship was fast
# SPACESHIP_PROMPT_ADD_NEWLINE=(false)
# SPACESHIP_PROMPT_SEPARATE_LINE=(false)
# SPACESHIP_NODE_SHOW=(false)

# plugins
plugins=(git)

autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

export TERM=screen-256color

# path
export PATH=$PATH:/usr/local/share/npm/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/bin:$PATH

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='
  --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
  --color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

# alias
alias ls='ls -lah'

# misc
eval `docker-machine env 2>/dev/null`

# init!
source $ZSH/oh-my-zsh.sh

export EDITOR=vim

export GOPATH=${HOME}/src/go
eval $(/opt/homebrew/bin/brew shellenv)
