# Version Controlled Dotfiles
This is my dotfile configuration for Mac OS X. 

# Prerequisites
- Ruby installed with Rake

# Installation
Running the below commands will clone this repo into `~/.dotfiles` and set it up as your current dotfile configuration. Running a custom rake task will backup existing `.bash_profile` and `.gitignore_global` files, unlink any symlinks for those files and create symlinks to them from the `.dotfiles` version.

```terminal
git clone git://github.com/nikymorg/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake
```

# Uninstall
A custom rake task will uninstall by removing the symlinks, removing `.dotfiles` directory and moving your backup bash profile and gitignore files back into place.

```terminal
rake uninstall
```