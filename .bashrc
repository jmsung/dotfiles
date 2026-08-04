# Quit early if not interactive
[[ $- != *i* ]] && return

# Terminal & color support
export TERM=xterm-256color
export CLICOLOR=1

# OS + Homebrew prefix — portable across macOS (/opt/homebrew) and Linuxbrew
case "$OSTYPE" in darwin*) IS_MAC=1 ;; *) IS_MAC=0 ;; esac
if   [ -x /opt/homebrew/bin/brew ];            then BREW_PREFIX=/opt/homebrew
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then BREW_PREFIX=/home/linuxbrew/.linuxbrew
elif [ -x /usr/local/bin/brew ];               then BREW_PREFIX=/usr/local; fi

# Homebrew’s Ruby (3.x) first in PATH — only if that brew has it
[ -n "$BREW_PREFIX" ] && [ -d "$BREW_PREFIX/opt/ruby/bin" ] && export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

# Source modular configs — a distinct SSH/Linux server prompt, else the local one
if { [ -n "$SSH_CONNECTION" ] || [ "$IS_MAC" = 0 ]; } && [ -f ~/.bash_server_prompt ]; then
  source ~/.bash_server_prompt
elif [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi
[ -f ~/.bash_aliases ]      && source ~/.bash_aliases
[ -f ~/.private ]      && source ~/.private

# Source secrets securely
[ -f ~/.secrets/google.env ] && source ~/.secrets/google.env

# Git auto-completion (optional)
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# Bash history behavior
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Enable VS Code shell integration (only when running inside VS Code)
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  [[ -f "$(command -v code)" ]] && . "$(code --locate-shell-integration-path bash)"
fi

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Upgrade claude-code once/day, in background — fast (no auto-update), non-racy (throttled
# so many terminals don't fight brew's lock), logged (~/.cache/claude-upg.log).
# macOS only — claude-code ships as a Homebrew cask there; skip on Linux.
# Wrapped in an outer subshell so the interactive shell doesn't track the
# background job and print a "[1]+ Done" notice when it finishes.
if [ "$IS_MAC" = 1 ] && [ -n "$BREW_PREFIX" ]; then
( { mkdir -p ~/.cache; s=~/.cache/claude-upg.stamp
    if [ ! -f "$s" ] || [ -n "$(find "$s" -mtime +1)" ]; then
      HOMEBREW_NO_AUTO_UPDATE=1 "$BREW_PREFIX/bin/brew" upgrade --cask claude-code >~/.cache/claude-upg.log 2>&1
      touch "$s"
    fi
  } & )
fi
