HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

bindkey -e

# Enable autocompletion and arrow key selection for 'ls' output
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
autoload -Uz compinit
compinit

function git_prompt_info() {
  git_info=$(~/bin/git-prompt.rb 2> /dev/null) || return
  echo " $git_info"
}

function rvm_prompt_info() {
  ruby_version=$(rvm-prompt 2> /dev/null) || return
  echo " - $ruby_version"
}

setopt prompt_subst
PS1=$'%n:%~$(git_prompt_info)$(rvm_prompt_info)\n%# '

source ~/.profile

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
