# Bootstrap. Deliberately plain sh + whatever make macOS ships (GNU Make 3.81),
# so the one thing that has to run on an unconfigured machine depends on
# nothing but the Command Line Tools that `git clone` already required.

SHELL := /bin/sh
DEST  ?= $(HOME)
XDG   ?= $(DEST)/.config

# Top-level entries that map to ~/.<name>. $(wildcard *) skips dotfiles
# already, so .gitignore stays out of this without being named.
FILES := $(filter-out Makefile README.md nvim,$(wildcard *))

# src|dst pairs. Most go to ~/.<name>; nvim is XDG and needs its own row.
# Single-quoted so the shell sees the | as data, not a pipe.
LINKS := $(foreach f,$(FILES),'$(CURDIR)/$(f)|$(DEST)/.$(f)')
LINKS += '$(CURDIR)/nvim|$(XDG)/nvim'

.DEFAULT_GOAL := help
.PHONY: help install force unlink deps list

help:
	@echo "make install   symlink everything into place, never clobbering"
	@echo "make force     same, but replace whatever is in the way"
	@echo "make unlink    remove only the symlinks that point back here"
	@echo "make deps      install the tools these configs assume"
	@echo "make list      show what install would manage"

list:
	@for l in $(LINKS); do \
	  echo "  `echo $$l | cut -d'|' -f1` -> `echo $$l | cut -d'|' -f2`"; \
	done

install:
	@mkdir -p "$(XDG)"
	@for l in $(LINKS); do \
	  src=`echo $$l | cut -d'|' -f1`; dst=`echo $$l | cut -d'|' -f2`; \
	  if [ -L "$$dst" ] && [ "`readlink \"$$dst\"`" = "$$src" ]; then \
	    echo "  ok       $$dst"; \
	  elif [ -e "$$dst" ] || [ -L "$$dst" ]; then \
	    echo "  EXISTS   $$dst  (make force to replace)"; \
	  else \
	    ln -s "$$src" "$$dst" && echo "  linked   $$dst"; \
	  fi; \
	done

# Guarded: an empty dst here would expand to rm -rf on a parent directory,
# and that is not a mistake worth leaving available.
force:
	@mkdir -p "$(XDG)"
	@for l in $(LINKS); do \
	  src=`echo $$l | cut -d'|' -f1`; dst=`echo $$l | cut -d'|' -f2`; \
	  [ -n "$$src" ] && [ -n "$$dst" ] || continue; \
	  rm -rf -- "$$dst"; \
	  ln -s "$$src" "$$dst" && echo "  linked   $$dst"; \
	done

unlink:
	@for l in $(LINKS); do \
	  src=`echo $$l | cut -d'|' -f1`; dst=`echo $$l | cut -d'|' -f2`; \
	  if [ -L "$$dst" ] && [ "`readlink \"$$dst\"`" = "$$src" ]; then \
	    rm -f -- "$$dst" && echo "  unlinked $$dst"; \
	  fi; \
	done

deps:
	brew install neovim starship zsh-autosuggestions zsh-syntax-highlighting \
	             zsh-completions the_silver_searcher tmux
	# typescript pinned to 5: TS 7 is the Go rewrite and ships no tsserver.js,
	# which typescript-language-server needs to start at all.
	npm install -g typescript@5 typescript-language-server pyright
	go install golang.org/x/tools/gopls@latest
