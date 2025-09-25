# Source .bashrc for shared settings
[ -f ~/.bashrc ] && source ~/.bashrc

# Optional: iTerm2 integration
[ -f "${HOME}/.iterm2_shell_integration.bash" ] && source "${HOME}/.iterm2_shell_integration.bash"
eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jmsung/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jmsung/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jmsung/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jmsung/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


. "$HOME/.local/bin/env"
