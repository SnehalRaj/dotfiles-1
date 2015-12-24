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


uninstall_screenfetch() {
  # Check if screenfetch is installed
  rm ~/dotfiles/screenfetch # Remove local copy
  # Remove global copy if installed
  if [ -f /usr/bin/screenfetch -o -f /bin/screenfetch ]; then
    echo -n "Do you want to uninstall ScreenFetch?(N/y) "
    read -n 1 opt
    if [ "$opt" = "y" -o "$opt" = "Y" ]; then
      platform=$(uname);
      if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
          sudo yum remove screenfetch
          echo "ScreenFetch has been uninstalled."
        elif [[ -f /etc/debian_version ]]; then
          sudo apt-get remove screenfetch
          echo "ScreenFetch has been uninstalled."
        else
          echo "Please uninstall ScreenFetch on your own."
        fi
      else
        echo "Please uninstall ScreenFetch on your own."
      fi
    fi
  fi
}
uninstall_screenfetch
echo "Yash's dotfiles uninstallation complete."
