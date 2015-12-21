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

#Perform Installation
for file in $files; do
  echo -n "Moving any existing .$file to $olddir ..."
  mv ~/.$file $olddir/
  echo "Done."
  echo -n "Creating symlink for .$file  ..."
  ln -s $dir/$file ~/.$file
  echo "Done."
done
