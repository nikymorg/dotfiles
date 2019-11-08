# NIKYMORG BASH PROFILE
# =====================

# Sourcing files
for file in ~/.dotfiles/bash/{aliases.sh,environment.sh,functions.sh,prompt.sh,git_autocomplete.sh}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

__git_complete gco _git_checkout
