#!/bin/bash
####################
# .make.sh
# This script creates symlinks for backed up dotfiles
####################

########## Variables

dir=~/dotfiles
olddir=~/dotfiles.bak
files="bash_aliases bashrc selected_editor gitconfig gvimrc vim vimrc"

##########

# Create backup directory for existing dotfiles
echo -n "Creating $olddir for backup of existing dotfiles in ~ ..."
mkdir -p $olddir
echo "Done."

# Change to the dotfils directory
echo -n "Changing to the %dir directory ..."
cd $dir
echo "Done."

# Perform Installation
for file in $files; do
  echo -n "Moving any existing .$file to $olddir ..."
  mv ~/.$file $olddir/
  echo "Done."
  echo -n "Creating symlink for .$file  ..."
  ln -s $dir/$file ~/.$file
  echo "Done."
done

install_screenfetch() {
# Check if screenfetch is already installed
  if [ -f /usr/bin/screenfetch -o -f /bin/screenfetch ]; then
    echo "Good, you already have screenfetch installed."
  else
    echo -n "Do you want to install ScreenFetch?(Y/n) "
    read -n 1 opt
    if [ "$opt" = "n" ]; then
      echo ""
      echo "ScreenFetch will not be installed."
    elif [ "$opt" = "N" ]; then
      echo "ScreenFetch will not be installed."
    else
      platform=$(uname);
      if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
          sudo yum install lsb-release scrot
          wget -O screenfetch "https://raw.github.com/KittyKat/screenFetch/master/screenfetch-dev"
          chmod +x screenfetch
          echo "ScreenFetch has been installed."
        elif [[ -f /etc/debian_version ]]; then
          sudo apt-get install lsb-release scrot
          wget -O screenfetch "https://raw.github.com/KittyKat/screenFetch/master/screenfetch-dev"
          chmod +x screenfetch
          echo "ScreenFetch has been installed."
        else
          echo "Please install ScreenFetch on your own."
        fi
      else
        echo "Please install ScreenFetch on your own."
      fi
    fi
  fi
}
install_screenfetch
chmod +x fsearch
echo "Yash's dotfiles installation complete."
