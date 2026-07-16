# Quit early if not interactive
[[ $- != *i* ]] && return

# Terminal & color support
export TERM=xterm-256color
export CLICOLOR=1

# Ensure Homebrew’s Ruby (3.x) is first in PATH
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Source modular configs
[ -f ~/.bash_prompt ] && source ~/.bash_prompt
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

. "$HOME/.local/bin/env"

# Upgrade claude-code once/day, in background — fast (no auto-update), non-racy (throttled
# so many terminals don't fight brew's lock), logged (~/.cache/claude-upg.log).
{ mkdir -p ~/.cache; s=~/.cache/claude-upg.stamp
  if [ ! -f "$s" ] || [ -n "$(find "$s" -mtime +1)" ]; then
    HOMEBREW_NO_AUTO_UPDATE=1 /opt/homebrew/bin/brew upgrade --cask claude-code >~/.cache/claude-upg.log 2>&1
    touch "$s"
  fi
} &
