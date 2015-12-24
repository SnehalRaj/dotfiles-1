##############################################################################
#   Filename: .bash_aliases                                                  #
# Maintainer: Yash Srivastav <yash111998@gmail.com>                          #
#        URL: http://github.com/yash111998/dotfiles                          #
#                                                                            #
##############################################################################
# Get package
alias getme='sudo apt-get install'
# Execute previous command with sudo permissions
alias wtf='sudo $(history -p !!)'
# I accidentally type .. instead of cd ..
alias ..='cd ..'
# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"
# Shortcut for git upload
alias gpom='git push origin master'
