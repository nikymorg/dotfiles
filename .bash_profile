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

  # Define a variable to reset the text color
  local   RESET="\[\e[0m\]"

  #Export PS1 prompt text
  export  PS1="\[\e]2;\u@\h\a$RESET\t$RESET$RED\$(parse_git_branch) $GREEN\W\n$BLUE//$RED $CHAR $RESET"
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
export VISUAL="atom"
export SVN_EDITOR="atom"
export GIT_EDITOR="atom"
export EDITOR="atom"

# GIT_MERGE_AUTO_EDIT
# This variable configures git to not require a message when you merge.
export GIT_MERGE_AUTOEDIT='no'

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

# Sourcing files
source /Users/$USER/.bashrc
source /Users/$USER/.alias
source /Users/$USER/.functions
source /Users/$USER/.env

# NVM
# Mandatory loading of NVM into the shell
# This must be the last line of your bash_profile always
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# RVM
# Mandatory loading of RVM into the shell
# This must be the last line of your bash_profile always
[[ -s "/Users/$USER/.rvm/scripts/rvm" ]] && source "/Users/$USER/.rvm/scripts/rvm"  # This loads RVM into a shell session.
