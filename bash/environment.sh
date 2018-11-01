# Environment
# =====================

# GIT_MERGE_AUTO_EDIT
# This variable configures git to not require a message when you merge.
export GIT_MERGE_AUTOEDIT='no'

# Editors
# Tells your shell that when a program requires various editors, use atom.
export VISUAL="atom"
export SVN_EDITOR="atom"
export GIT_EDITOR="atom"
export EDITOR="atom"

# Library Paths
# =====================
export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

export PATH="$USR_PATHS:$PATH"

# Postgres
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# SQlite
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# OpenSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Mongo
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# RBENV - Ruby Version Manager
eval "$(rbenv init -)"