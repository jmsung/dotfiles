# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# File Management
alias cleanup='find . -type f -name '\''*.DS_Store'\'' -delete'

# LS and Color
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export LS_COLORS="rs=0:di=1;38;5;226:ln=38;5;51:so=38;5;226:pi=38;5;226:ex=1;38;5;129:bd=48;5;33:cd=48;5;33:su=48;5;197:sg=48;5;197:tw=48;5;10:ow=48;5;10:st=48;5;13:mi=0;38;5;15:*.rpm=38;5;33:*.deb=38;5;202:*.gz=38;5;214:*.tar=38;5;214:*.zip=38;5;214:*.png=38;5;201:*.jpg=38;5;201:*.txt=38;5;252:*.md=38;5;252:*.sh=38;5;198:di=1;36"

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git
alias gs='git status'
alias gss='git status --short'
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gcb='git rev-parse --abbrev-ref HEAD'
alias gcf='git commit --fixup'
alias gcm='git commit -m '
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log --oneline --graph --decorate'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias glg='git log --graph --oneline --decorate --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpf='git push -f'
alias gpr='git pull --rebase'
alias gps='git push'
alias gr='git rebase'
alias gsq='git reset 9473277a6e0e8aef2c0aa79343d2912ed1a3e55d'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# Jupyter
alias lab='jupyter-lab'

# Process / tools
alias htop='htop --sort-key PERCENT_CPU'

# Network
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'

# Miscellaneous
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias path='echo -e ${PATH//:/\n}'
alias pn='pnpm'
