# Quit early if not interactive
[[ $- != *i* ]] && return

# Terminal & color support
export TERM=xterm-256color
export CLICOLOR=1

# Source modular configs
[ -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.private ] && source ~/.private

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
