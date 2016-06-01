# Add yourself some shortcuts to projects you often work on
# Example:
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#
# Allow sudo to be used by aliases
alias sudo='sudo '
# Get package
alias getme='sudo apt-get install'
# Execute previous command with sudo permissions
alias wtf='sudo $(history -p !!)'
# I accidentally type .. instead of cd ..
alias ..='cd ..'
# This is for finding out what is taking so much space on your drives!
alias diskspace='du -S | sort -n -r |more'
# Shortcut for git upload
alias gpom='git push origin master'
# IP Address ( actual and local)
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
# ADB and fastboot
alias adb='sudo /home/yash/adb/platform-tools/adb '
alias fastboot='sudo /home/yash/adb/platform-tools/fastboot '
# Shutdown
alias shutdown='sudo shutdown now'
# Alias for fortune
alias woo='fortune'
alias f='fortune | cowsay'
alias fsearch='~/dotfiles/fsearch'
# Use python3 instead of python2
alias python='python3 '
# Open anything
alias o='gnome-open 2>/dev/null'
# Colored ghci
#alias ghci='ghci --colour'
# Brightness
alias bright='xrandr --output LVDS1 --brightness'
alias :q='exit'
# Location of linefollow
linefollow=/home/yash/RconGit/Rcon16/Ecobot/LineDetectionIP
# Location of alias
customize=/home/yash/.oh-my-zsh/custom
# Utorrent
alias utorrent='cd /opt/utorrent/ && sudo ./utserver '
# NeoVim
alias vim='nvim'
# Ixchel
alias cassandra='sudo docker run --name ixchel-cassandra -p 9042:9042 cassandra'
alias postgres='sudo docker run --name ixchel-db -e POSTGRES_PASSWORD=lehcxi -e POSTGRES_USER=ixchel -e POSTGRES_DB=IXCHEL -p 5432:5432 postgres'
alias pgprompt='sudo docker exec -ti ixchel-db psql --username ixchel --password IXCHEL'
alias csprompt='sudo docker run -it --link ixchel-cassandra:cassandra --rm cassandra cqlsh cassandra'
alias setupdocker='sudo pkill docker && sudo docker daemon -g /media/yash/Extra/docker'
alias rundocker='sudo docker daemon -g /media/yash/Extra/docker'
alias couchbase='sudo docker run -d -v ~/couchbase:/opt/couchbase/var --net=host couchbase/server'
# Altium
alias altium='DRI_PRIME=1 wine /home/yash/.wine/drive_c/Program\ Files/Altium/AD15/DXP.EXE'
# Weather
alias weather='curl wttr.in/kanpur'
