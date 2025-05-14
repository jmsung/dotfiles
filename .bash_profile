# Source .bashrc for shared settings
[ -f ~/.bashrc ] && source ~/.bashrc

# Optional: iTerm2 integration
[ -f "${HOME}/.iterm2_shell_integration.bash" ] && source "${HOME}/.iterm2_shell_integration.bash"
eval "$(/opt/homebrew/bin/brew shellenv)"
