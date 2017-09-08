# NIKYMORG BASH PROFILE
# =====================

# Sourcing files
for file in ~/.dotfiles/bash/{.env,aliases,bashrc,environment,functions,git_autocomplete,prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
