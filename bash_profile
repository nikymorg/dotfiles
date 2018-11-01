# NIKYMORG BASH PROFILE
# =====================

# Sourcing files
for file in ~/.dotfiles/bash/{aliases.sh,environment.sh,functions.sh,git_autocomplete.sh,prompt.sh}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
