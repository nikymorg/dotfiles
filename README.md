# Version Controlled Dotfiles
This is my dotfile configuration for Mac OS X.

# Installation
Running the below commands in Terminal will clone this repo into `~/.dotfiles`. After cloning it will create a symlink for your bash profile so that it will be sourced as if it were placed in the HOME directory. Your bash profile in turn will source the other dotfiles.

```terminal
cd ~
git clone git://github.com/nikymorg/dotfiles ~/.dotfiles
unlink ~/.bash_profile
ln -s ~/.dotfiles/.bash_profile ~/
```

# Uninstall
To uninstall, remove the bash profile symlink and remove the dotfiles from your system.

```terminal
unlink ~/.bash_profile
rm -rf ~/.dotfiles
```
