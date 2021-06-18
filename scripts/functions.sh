# Helper Functions
# =====================

# File Shortcuts
# =====================

# source zprofile
function sz {
  source /Users/$USER/.zprofile
}

# cd into desktop
function desktop {
  cd /Users/$USER/Desktop/
}

# cd and open dotfiles
function dot {
  cd /Users/$USER/.dotfiles
  $EDITOR .
}

# cd into code dir
function code {
  cd /Users/$USER/code
}

# open notes
function notes {
  $EDITOR /Users/$USER/notes
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
