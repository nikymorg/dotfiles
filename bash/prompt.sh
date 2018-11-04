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
  local   GRAY="\[\e[0;37m\]"

  # Define a variable to reset the text color
  local   RESET="\[\e[0m\]"

  #Export PS1 prompt text
  export  PS1="\[\e]2;\u@\h\a$GRAY\t$RESET$RED\$(parse_git_branch) $GREEN\W\n$BLUE//$RED $CHAR $RESET"
    PS2='> '
    PS4='+ '
}

# call prompt
prompt