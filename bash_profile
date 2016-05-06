export EDITOR="vim"
export PATH=/usr/local/sbin:$PATH
export NODE_PATH=/usr/local/lib/node_modules
export PATH=$(brew --prefix ruby)/bin:$PATH
export PATH=~/.local/bin:$PATH

# network analysis
alias httpdump='sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"'
alias httpgrep='ngrep -W byline port 80'
alias httpshark="tshark 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"

# cd
alias ..='cd ..'

# ls
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

# git
alias gl='git log'
alias gp='git push'
alias gpom='git push origin master'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias pull='git pull'
alias deploy='git push heroku master'
alias gh='git push heroku'

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# awscli
complete -C aws_completer aws
