# Helper Functions
# =====================

# Get the default branch (main or master)
function get_default_branch {
  # Try to get from origin/HEAD
  local branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  
  # If that fails, check which exists locally
  if [ -z "$branch" ]; then
    if git show-ref --verify --quiet refs/heads/main; then
      branch="main"
    elif git show-ref --verify --quiet refs/heads/master; then
      branch="master"
    else
      branch="main"  # default fallback
    fi
  fi
  
  echo "$branch"
}

# Checkout default branch (main or master)
function gcm {
  git checkout $(get_default_branch)
}

# Rebase onto default branch (main or master)
function grm {
  git rebase $(get_default_branch)
}

# Other Functions
# =====================

# check what is running on a specific port
function checkport {
  lsof -i :$1;
}

# find processes running on a specific port and kill them
function killport {
  lsof -ti :$1 | xargs kill -9
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# clone and cd
function gitget {
  reponame=${1##*/}
  reponame=${reponame%.git}
  git clone "$1" "$reponame";
  cd "$reponame";
  if [ -f ./package.json ] && [ ! -f Gemfile ]; then
  yarn install;
  elif [ -f Gemfile ] && [ ! -f ./package.json ]; then
  bundle install;
  else
  printf "\n(nothing to install...)\n"
  fi
}

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}

function tmux_dev {
  tmux new-session -d -s dev 'nvim'
  tmux new-window -t dev:1 -n tests
  tmux new-window -t dev:2 -n console 'bin/console'
  tmux new-window -t dev:3 -n server 'script/server --debug'
  tmux attach-session -t dev:0
}

# Open git repository in browser
function git-open {
  url=$(git config --get remote.origin.url 2>/dev/null)
  if [ -z "$url" ]; then
    echo "No git remote found"
    return 1
  fi
  
  # Convert SSH format to HTTPS
  url=${url/git@github.com:/https://github.com/}
  url=${url%.git}
  
  if [[ $CODESPACES ]]; then
    echo "$url"
  else
    # MacOS: open in default browser
    open "$url" 2>/dev/null || xdg-open "$url" 2>/dev/null || echo "$url"
  fi
}
