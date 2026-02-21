# Version Controlled Dotfiles
This is my dotfile configuration for Mac OS X and GitHub Codespaces.

## What's Included

Configuration files for:
- **Shell**: bash and zsh configurations with custom prompts
- **Editor**: neovim (nvim) configuration
- **Terminal**: tmux configuration
- **Git**: global gitignore and settings
- **Aliases & Functions**: Productivity shortcuts and helper functions

## Organization

Scripts are organized by platform in `scripts/`:
- `common/` - Shared across MacOS and Codespaces
- `macos/` - MacOS-specific configuration
- `codespaces/` - GitHub Codespaces-specific configuration

## Installation

### MacOS

**Prerequisites:** Command line tools must be installed. Install with:
```terminal
xcode-select --install
```

**Setup:** Clone this repo into `~/.dotfiles` and run the setup script:
```terminal
git clone https://github.com/nikymorg/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./setup.sh
```

### GitHub Codespaces

No manual setup needed - Codespaces auto-configures on launch.

### What setup.sh does

- Links dotfiles to your home directory (`.bashrc`, `.zshrc`, `.vimrc`, etc.)
- Installs Homebrew (if not present)
- Installs packages from Brewfile
- **MacOS**: Installs npm packages
- **Codespaces**: Optionally bootstraps your workspace repository
