# NIKYMORG BASH PROFILE
# forked from Flatiron School bash profile
# https://github.com/flatiron-school/dotfiles/blob/master/bash_profile
# ======================

# Prompt
# =====================
# called in prompt to output active git branch
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# build prompt
function prompt {
  # Define the prompt character
  local   CHAR="♥"

  # Define some local colors
  local   RED="\[\e[0;31m\]"
  local   BLUE="\[\e[0;34m\]"
  local   GREEN="\[\e[0;32m\]"
  local   GRAY_TEXT_BLUE_BACKGROUND="\[\e[37;44;1m\]"

  # Define a variable to reset the text color
  local   RESET="\[\e[0m\]"

  #Export PS1 prompt text
  export  PS1="\[\e]2;\u@\h\a[$GRAY_TEXT_BLUE_BACKGROUND\t$RESET]$RED\$(parse_git_branch) $GREEN\W\n$BLUE//$RED $CHAR $RESET"
    PS2='> '
    PS4='+ '
}

# call prompt
prompt

# Environment Variables
# =====================
# Library Paths
# These variables tell your shell where they can find certain required libraries
#so other programs can reliably call the variable name instead of a hardcoded path.

# NODE_PATH
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# Postgres
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Paths
# =====================
# The USR_PATHS variable will store all relevant /usr paths for easier usage
# Each path is separated via a : and we always use absolute paths.

# The /usr directory is a convention from Linux that creates a common place to put
# files and executables that the entire system needs access too. It tries to be user
# independent, so whichever user is logged in should have permissions to the /usr directory.
# We call that /usr/local. Within /usr/local, there is a bin directory for actually
# storing the binaries (programs) that our system would want.
# Also, Homebrew adopts this convention so things installed via Homebrew get symlinked into /usr/local
export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

# We build our final PATH by combining the variables defined above
# along with any previous values in the PATH variable.
export PATH="$USR_PATHS:$PATH"

# Configurations
# =====================

# Editors
# Tells your shell that when a program requires various editors, use atom.
# The -w flag tells your shell to wait until atom exits
export VISUAL="atom -w"
export SVN_EDITOR="atom -w"
export GIT_EDITOR="atom -w"
export EDITOR="atom -w"

# GIT_MERGE_AUTO_EDIT
# This variable configures git to not require a message when you merge.
export GIT_MERGE_AUTOEDIT='no'

# Helper Functions
# =====================

# open bash profile
function bp {
  $EDITOR ~/.bash_profile
}

# cd into desktop
function desktop {
  cd /Users/$USER/Desktop/$@
}

# cd into dev dir
function development {
  cd /Users/$USER/Dev/$@
}

# cd and open ironboard
function iron {
  cd /Users/$USER/Development/Flatiron/ironboard/$@
  $EDITOR .
}

# clone and cd
function gitget {
  reponame=${1##*/}
  reponame=${reponame%.git}
  git clone "$1" "$reponame";
  cd "$reponame";
  if [ -f ./package.json ] && [ ! -f Gemfile ]; then
   yarn install;
  elif [ -f Gemfile ] && [ ! -f ./package.json ]; then
   bundle install;
  else
   printf "\n(nothing to install...)\n"
  fi
}

# cd up clone and cd
function gitup {
  cd ../
  reponame=${1##*/}
  reponame=${reponame%.git}
  git clone "$1" "$reponame";
  cd "$reponame";
  if [ -f ./package.json ] && [ ! -f Gemfile ]; then
   yarn install;
  elif [ -f Gemfile ] && [ ! -f ./package.json ]; then
   bundle install;
  else
   printf "\n(nothing to install...)\n"
  fi
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# A function to bring local ironboard repo completely up to date
# USE: cd into /ironboard first, then run command
function ibgo () {
  git pull --rebase --prune                  # pull down latest from master + prune unused branches
  git gc                                     # compress
  bundle                                     # run bundler to install/update gems
  yarn install                               # run yarn install to install/update packages
  bin/rake db:migrate RAILS_ENV=development  # run dev db migrations
  bin/rake db:migrate RAILS_ENV=test         # run test db migrations
  git checkout -- db/schema.rb               # discard db schema changes
}

# Aliases
# =====================
# LS
alias l='ls -lah'

# db
alias dbmtest='rake db:migrate RAILS_ENV=test'
alias dbmdev='rake db:migrate RAILS_ENV=development'

# Git
alias gco="git checkout"
alias gcl="git clone"
alias gst="git status"
alias gd="git diff | atom"
alias gl="git pull"
alias glr="git pull --rebase --prune"
alias gp="git push"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gcam="git commit -am"
alias gba="git branch -a"
alias gbv="git branch -v"
alias gbdall="git branch | grep -v 'master' | xargs git branch -D"
alias gcm="git checkout master"
alias grm="git rebase master"

# Jekyll
alias js='jekyll serve'

# Rspec
alias rff="rspec --fail-fast"

# Atom
alias atom='open -a /Applications/Atom.app'

# Sublime Text
alias subl='open -a /Applications/Sublime\ Text.app'

# # Hub
# eval "$(hub alias -s)"
# alias hubpr="hub pull-request -o"
# alias hubb="hub browse"
# alias hubc="hub compare $(git rev-parse --abbrev-ref HEAD)"

# Rails
alias rs='rails s'
alias rc='rails c'
alias rcs='rails c --sandbox'

# Finder - Show / Unshow Hidden Files
alias reveal='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias rehide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# cssh
# https://github.com/flatiron-labs/operations/wiki/i2cssh
alias cssh='i2cssh -c'

# Case-Insensitive Auto Completion
# =====================
bind "set completion-ignore-case on"

# Final Configurations and Plugins
# =====================
# Git Bash Completion
# Will activate bash git completion if installed
# via homebrew
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#   . `brew --prefix`/etc/bash_completion
#   GIT_PS1_SHOWDIRTYSTATE=true
#   GIT_PS1_SHOWUNTRACKEDFILES=true
# fi

source ~/.bashrc

# NVM
# Mandatory loading of NVM into the shell
# This must be the last line of your bash_profile always
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# RVM
# Mandatory loading of RVM into the shell
# This must be the last line of your bash_profile always
[[ -s "/Users/$USER/.rvm/scripts/rvm" ]] && source "/Users/$USER/.rvm/scripts/rvm"  # This loads RVM into a shell session.
