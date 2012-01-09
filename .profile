# Settings/aliases that work in both Bash and ZSH

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export LC_ALL=en_NZ.UTF-8
export LANG=en_NZ.UTF-8

# Some other sensible defaults
export BROWSER='/Applications/Firefox.app/Contents/MacOS/firefox'
export EDITOR='/Applications/TextMate.app/Contents/MacOS/TextMate'
export PAGER=less

# HIDDEN FILES
alias show_hidden_files='defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder'
alias hide_hidden_files='defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder'

# GIT ALIASES
alias g='git'
alias gs='git status'
alias gd='git diff HEAD'
alias gdiff='gd > /tmp/changes.diff && mate /tmp/changes.diff'
alias gb='git branch'
alias gl='git lg'

# APPLICATION TESTING
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integration'
alias rs='rake db:test:prepare && rspec spec'
alias rc='rake cucumber'
function rcf {
 rake cucumber FEATURE=features/"$1".feature
}

# MYSQL
alias mysql_start='/usr/local/share/mysql/mysql.server start'
alias mysql_stop='/usr/local/share/mysql/mysql.server stop'

# POSTGRES
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# HOMEBREW SHORTCUTS
function bi {
  brew install $1 --universal --build-from-source
}
function bu {
  brew upgrade $1 --universal --build-from-source
}

# OTHER
alias m='mate .'
alias ls="ls -G" # Colouring
alias c="clear"
alias freemem='sudo killall -9 ruby delayed_job; /usr/bin/purge'

# RVM (Ruby Version Manager)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
