#!/bin/bash
####################
# .make.sh
# This script restores backed up dotfiles
####################

########## Variables

dir=~/dotfiles
olddir=~/dotfiles.bak
files="bash_aliases bashrc selected_editor gitconfig gvimrc vim vimrc"
exist=0
##########

# Check if backup directory exists
if [ ! -d "$olddir" ]; then
  echo -n "$olddir does not exist and hence nothing to restore."
else 
  echo -n "Restoring from existing backup : $olddir"
  exist=1
fi

# Change to the dotfiles backup directory
echo -n "Changing to the $olddir directory ..."
cd $olddir
echo "Done."

#Perform UnInstallation
for file in $files; do
  echo -n "Deleting .$file ..."
  rm ~/.$file
  echo "Done."
  if [ "$exist" == "1" ]; then
    echo -n "Restoring old .$file  ..."
    mv $olddir/.$file ~/.$file
    echo "Done."
  fi
done
