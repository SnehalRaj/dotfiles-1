# Yash's dotfiles
Contains the following dotfiles:
* .bashrc         : My custom bashrc
* .bash_aliases   : My custom aliases
* .zshrc          : custom zshrc
* zsh-custom/alias.zsh : custom aliases
* .conkyrc        : [deprecated] Information for my i3 desktop
* .selected_editor: **Vim**
* .vim            : the reason for my existence( now in its own repo)
* .gitconfig      : some git settings
* .i3             : The tiling window manager - ~~Next step towards Arch :P~~[Already There :P]

zsh-custom contains my own theme(yashpl) inspired by the powerline theme in zsh(agnoster maybe) with few customizations of
my own to resemble [liquidprompt](http://github.com/nojhan/liquidprompt) a little bit.

My i3 uses `rofi` as the application launcher and `i3blocks` for the `i3bar` instead of the default `i3status`.  
I also use `i3-gaps` and `i3-blocks-gaps` instead of the usual i3 utilities.  
My i3lock is forked from [here](http://github.com/Lixxia/i3lock) for a better display.  
My terminal is [st](http://st.suckless.org)  
Music Player - cmus  
Gtk Theme - Arc Darker Theme  
Browser - Firefox with Pentadactyl and Arc Darker Theme  

Also contains:
oh-my-zsh folder and zsh-custom folder and some shell scripts  
My zsh-custom contains a custom theme which is heavily inspired by liquid prompt
and adjusts itself as per width of the terminal, displaying lots of data on a larger
terminal and lesser data on a smaller terminal.

* install.sh : installs my dotfiles
* uninstall.sh : uninstalls my dotfiles
* zsh.sh : nifty script for battery monitoring on my zsh rprompt
