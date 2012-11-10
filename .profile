# Settings/aliases that work in both Bash and ZSH

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export LC_ALL=en_NZ.UTF-8
export LANG=en_NZ.UTF-8

# To stop some things from barfing during compile
export CC=/usr/bin/llvm-gcc
export CXX=/usr/bin/llvm-g++
export LD=/usr/bin/llvm-gcc

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
alias rt='bundle exec rake test'
alias rtu='bundle exec rake test:units'
alias rtf='bundle exec rake test:functionals'
alias rti='bundle exec rake test:integration'
alias rs='bundle exec rake db:test:prepare && bundle exec rspec spec'
alias rc='bundle exec rake cucumber'
function rcf {
  bundle exec rake cucumber FEATURE=features/"$1".feature
}

# MYSQL
alias mysql_start='/usr/local/share/mysql/mysql.server start'
alias mysql_stop='/usr/local/share/mysql/mysql.server stop'

# POSTGRES
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# HOMEBREW SHORTCUTS
function bi {
  brew install -vd $1 --universal --build-from-source
}
function bu {
  brew upgrade -vd $1 --universal --build-from-source
}

# OTHER
alias m='mate .'
alias ls="ls -G" # Colouring
alias c="clear"
alias freemem='sudo killall -9 ruby delayed_job; /usr/bin/purge'

# RVM (Ruby Version Manager)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Tweak Ruby 1.9.3+ Garbage Collection Variables (default values x 10)
# http://www.web-l.nl/posts/15-tuning-ruby-s-garbage-collector-with-rvm-and-passenger
export RUBY_GC_MALLOC_LIMIT=59000000
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_FREE_MIN=100000
