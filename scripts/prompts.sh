# Prompt
# =====================

# output active git branch
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# build prompts
function bash_prompt {
  local   CHAR="♥"

  local   RED="\[\e[0;31m\]"
  local   BLUE="\[\e[0;34m\]"
  local   GREEN="\[\e[0;32m\]"
  local   GRAY="\[\e[0;37m\]"

  local   RESET="\[\e[0m\]"

  export  PS1="\[\e]2;\u@\h\a$GRAY\t$RESET$RED\$(parse_git_branch) $GREEN\W\n$BLUE//$RED $CHAR $RESET"
    PS2='> '
    PS4='+ '
}

function zsh_prompt {
    local CHAR="♥"
    autoload -U colors && colors

    precmd() {
      print -rP "%{$fg[green]%}%(4~|%-1~/.../%2~|%~)%{$fg[red]%}$(parse_git_branch)%{$reset_color%}%"
    }

    PS1="%{$reset_color%}%{$fg[blue]%}// %{$reset_color%}% %{$fg[red]%}%{$CHAR%} > %{$reset_color%}% "
    PS2='> '
    PS4='+ '
}
