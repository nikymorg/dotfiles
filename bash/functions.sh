# Helper Functions
# =====================

# File Shortcuts
# =====================

# open bash profile
function bp {
  $EDITOR /Users/$USER/.bash_profile
  $EDITOR /Users/$USER/.dotfiles
}

# source bash profile
function sbp {
  source /Users/$USER/.bash_profile
}

# cd into desktop
function desktop {
  cd /Users/$USER/Desktop/$@
}

# cd into dev dir
function development {
  cd /Users/$USER/Dev/$@
}

# cd and open dotfiles
function dot {
cd /Users/$USER/.dotfiles/$@
$EDITOR .
}

# cd and open ironboard
function iron {
  cd /Users/$USER/Dev/ironboard/$@
  $EDITOR .
}

# open notes
function notes {
  $EDITOR /Users/$USER/dev/notes/$@
}

# Other Functions
# =====================

# check what is running on a specific port
function checkport {
  port=$1;
  lsof -i tcp:$1;
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

# cd up clone and cd
function gitup {
  cd ../
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

# mkdir and cd into it
function mk {
  mkdir -p "$@" && cd "$@"
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
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
