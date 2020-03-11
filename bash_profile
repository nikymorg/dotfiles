# NIKYMORG BASH PROFILE
# =====================

# Sourcing files

for file in ~/.dotfiles/bash/*; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

