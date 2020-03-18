function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prompt adapted from Flatiron School dotfiles (https://github.com/flatiron-school/dotfiles)
function prompt {
    local CHAR="♥" ## ♥ ☆ ♬ ○ ♩ ● ♪ - Keeping some cool ASCII Characters for reference
    autoload -U colors && colors

    precmd() { print -rP "%{$fg[green]%}%(4~|%-1~/.../%2~|%~)%{$fg[red]%}$(parse_git_branch)%{$reset_color%}%" }

    PS1="%{$reset_color%}%{$fg[blue]%}// %{$reset_color%}% %{$fg[red]%}%{$CHAR%} > %{$reset_color%}% "
    PS2='> '
    PS4='+ '
}

prompt
