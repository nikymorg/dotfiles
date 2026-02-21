# MacOS-specific Functions
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
