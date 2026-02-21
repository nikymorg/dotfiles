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
alias gd="git diff | nvim"
alias gl="git pull"
alias glr="git pull --rebase --prune"
alias gp="git push -u origin HEAD"
alias gc="git commit"
alias gcm="git checkout main"
alias grm="git rebase main"
alias gop="git open"
alias grc="git rebase --continue"

# Rspec
alias rff="rspec --fail-fast"

# Rails
alias rs="rails s"
alias rc="rails c"
