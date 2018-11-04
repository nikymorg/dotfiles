# NIKYMORG BASH PROFILE
# =====================

# Sourcing files
for file in ~/.dotfiles/bash/{git_autocomplete.sh,aliases.sh,environment.sh,functions.sh,prompt.sh}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

__git_complete gco _git_checkout

