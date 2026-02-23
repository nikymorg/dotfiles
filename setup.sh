#!/bin/bash

# Strict error handling
set -euo pipefail

# log install
exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1

# Enable verbose logging if DEBUG is set
if [[ "${DEBUG:-}" == "1" ]]; then
  set -x
fi

# Trap errors and provide helpful context
trap 'echo "ERROR: Setup failed at line $LINENO. Check $HOME/dotfiles_install.log for details." >&2' ERR

# Standard error and warning functions
function fail {
  echo "ERROR: $1" >&2
  return 1
}

function fatal {
  echo "ERROR: $1" >&2
  exit 1
}

function warn {
  echo "WARNING: $1" >&2
}

function link_dotfiles {
  local dirpath="${PWD}/${1}/*"
  for filepath in $dirpath; do
    local filename
    filename=$(basename "$filepath")
    local linkpath="${HOME}/.${filename}"
    link_file "$filepath" "$linkpath"
  done

  # link nvim config
  local filepath=".config/nvim/init.lua"
  mkdir -p "${HOME}/.config/nvim" || fail "Failed to create nvim config directory"
  link_file "${PWD}/${1}/${filepath}" "${HOME}/${filepath}"
}

function link_file {
  local filepath="$1"
  local linkpath="$2"
  echo "Linking ${filepath} to ${linkpath}"
  
  if [[ -f "$linkpath" ]] || [[ -L "$linkpath" ]]; then
    rm "$linkpath" || fail "Failed to remove existing file at ${linkpath}"
  fi
  
  ln -s "$filepath" "$linkpath" || fail "Failed to create symlink from ${filepath} to ${linkpath}"
}

function config_gitignore {
  git config --global core.excludesfile ~/.gitignore || fail "Failed to configure git excludesfile"
}

function bootstrap_codespace {
  if [[ -z "${BOOTSTRAP_REPO:-}" ]]; then
    echo "Skipping bootstrap (BOOTSTRAP_REPO not set)"
    return 0
  fi
  
  local repo_name
  repo_name=$(echo "${GITHUB_REPOSITORY:-}" | cut -d'/' -f 2)
  
  if [[ -z "$repo_name" ]]; then
    warn "GITHUB_REPOSITORY not set, skipping workspace bootstrap"
    return 0
  fi
  
  local workspace_path="/workspaces/${repo_name}"
  
  if [[ ! -d "$workspace_path" ]]; then
    warn "Workspace directory ${workspace_path} not found, skipping bootstrap"
    return 0
  fi
  
  echo "Changing directory to ${workspace_path}"
  cd "$workspace_path" || fail "Failed to change to ${workspace_path}"

  if [[ -f "./bin/build-ctags" ]]; then
    echo "Building ctags"
    ./bin/build-ctags || warn "Failed to build ctags, continuing..."
  else
    echo "Skipping ctags (./bin/build-ctags not found)"
  fi

  if [[ -f "./script/bootstrap" ]]; then
    echo "Bootstrapping"
    ./script/bootstrap || fail "Bootstrap failed"
  else
    echo "Skipping bootstrap (./script/bootstrap not found)"
  fi

  if [[ -f "./bin/rake" ]]; then
    echo "Migrating the databases"
    ./bin/rake db:migrate db:test:prepare || warn "Database migration failed, continuing..."
  else
    echo "Skipping database migration (./bin/rake not found)"
  fi
}

function install_brew {
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed"
  else
    echo "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "Failed to install Homebrew"
  fi

  # Locate brew executable
  local brew_path=""
  if command -v brew >/dev/null 2>&1; then
    brew_path=$(command -v brew)
  elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ -x "/opt/homebrew/bin/brew" ]]; then
    brew_path="/opt/homebrew/bin/brew"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    brew_path="/usr/local/bin/brew"
  else
    fail "Cannot locate brew executable"
  fi

  echo "Installing Brew packages"
  local brewfile_path="${HOME}/.Brewfile"
  if [[ -f "$brewfile_path" ]]; then
    "${brew_path}" bundle --quiet --file="$brewfile_path" || fail "Brew bundle install failed"
  else
    fail "Brewfile not found at ${brewfile_path}"
  fi
}

function config_dotfiles {
  link_dotfiles "config" || fail "Failed to link dotfiles"
  config_gitignore || fail "Failed to configure gitignore"
}

function setup {
  echo "Starting dotfiles setup..."
  
  config_dotfiles || fatal "Dotfiles configuration failed"
  install_brew || fatal "Homebrew installation failed"
  
  if [[ $CODESPACES ]]; then
    bootstrap_codespace || fatal "Codespace bootstrap failed"
  fi
  
  echo "Peace out 🤖s!"
}

setup
