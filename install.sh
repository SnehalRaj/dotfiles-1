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

# Install archey
if [ -f /usr/bin/archey ]; then
  echo -n "Good, you already have archey installed."
else
  echo -n "Do you want to install archey?(Y/n) "
  read -n 1 opt
  if [ "$opt" == "N" || "$opt" == "n" ]; then
    echo -n "Archey will not be installed."
  else
    sudo apt-get install lsb-release scrot
    wget http://github.com/downloads/djmelik/archey/archey-0.2.8.deb
    sudo dpkg -i archey-0.2.8.deb
    rm archey-0.2.8.debi
    echo -n "Archey has been installed."
  fi
fi
echo -n "Yash's dotfiles installation complete."
