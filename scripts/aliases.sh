# Aliases
# =====================

# Dir Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# LS
alias l="ls -lah"

# db
alias dbmtest="rake db:migrate RAILS_ENV=test"
alias dbmdev="rake db:migrate RAILS_ENV=development"

# Git
alias gco="git checkout"
alias gcl="git clone"
alias gst="git status"
alias gd="git diff | vim"
alias gl="git pull"
alias glr="git pull --rebase --prune"
alias gp="git push -u origin HEAD"
alias gpr="hub pull-request"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gba="git branch -a"
alias gbv="git branch -v"
alias gbdall="git branch | grep -v "master" | xargs git branch -D"
alias gcm="git checkout master"
alias grm="git rebase master"
alias gop="git open"
alias grc="git rebase --continue"

# Rspec
alias rff="rspec --fail-fast"

# Python
alias python=/usr/local/bin/python3
alias pip=/Library/Frameworks/Python.framework/Versions/3.8/bin/pip3

# Rails
alias rs="rails s"
alias rc="rails c"
alias rcs="rails c --sandbox"

# Finder - Show / Unshow Hidden Files
alias reveal="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias rehide="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

