# Version Controlled Dotfiles
This is my dotfile configuration for Mac OS X.

# Prerequisites
- Ruby installed with Rake

# Installation
Running the below commands will clone this repo into `~/.dotfiles` and set it up as your current dotfile configuration. Running a custom rake task will backup existing `.bash_profile` and `.gitignore_global` files, unlink any symlinks for those files and create symlinks to them from the `.dotfiles` version.

```terminal
git clone https://github.com/nikymorg/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```
