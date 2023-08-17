#!/bin/bash

# log install
exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

function link_dotfiles {
  local dirpath="${PWD}/${1}/*"
  for filepath in $dirpath; do
    local filename=$(basename "$filepath")

    if [[ "$filename" == "nvim" ]]; then
      local nvimpath="${HOME}/.config/nvim"
      local linkpath="${nvimpath}/init.vim"
      mkdir -p "${nvimpath}"
      link_file $filepath $linkpath
    else
      local linkpath="${HOME}/.${filename}"
      link_file $filepath $linkpath
    fi
  done;
}

function link_file {
  local filepath=$1
  local linkpath=$2
  echo "linking ${filepath} to ${linkpath}"
  if [[ -f "$linkpath" ]]; then
    rm "$linkpath"
  fi
  ln -s ${filepath} ${linkpath}
}

function config_gitignore {
  git config --global core.excludesfile ~/.gitignore
}

function bootstrap_codespace {
  echo "Bootstrapping"
  ./script/bootstrap

  echo "Migrating the databases"
  ./bin/rake db:migrate db:test:prepare

  echo "Building ctags"
  ./bin/build-ctags
}

function install_brew {
  if [[ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    echo "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "Linking Homebrew"
  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  echo "Installing Brew packages"
  brew bundle --file="$HOME/.Brewfile"
}

function install_vim_plug {
  echo "Installing Vim Plug-ins"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"
}

function npm_install {
  echo "Installing NPM packages"
  npm install --global git-open
}

function default_setup {
  link_dotfiles "config"
  config_gitignore
  install_brew
  install_vim_plug
}

function codespaces_setup {
  default_setup
  bootstrap_codespace
}

function mac_setup {
  default_setup
  npm_install
}

function setup {
  if [[ $CODESPACES ]]; then
    codespaces_setup
  else
    mac_setup
  fi
  echo "Peace out 🤖s!"
}

setup
