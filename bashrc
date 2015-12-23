###############################################################################################################
#   Filename: .bashrc                                                                                         #
# Maintainer: Yash Srivastav <yash111998@gmail.com>                                                           #
#        URL: http://github.com/yash111998/dotfiles                                                           #
#                                                                                                             #
#                                                                                                             #
# Sections:                                                                                                   #
#   01. NonInteractive handling                                                                               #
#   02. History                                                                                               #
#   03. Some good mods                                                                                        #
#   04. Prompt Customization                                                                                  #
#   05. Aliases                                                                                               #
#   06. Completion                                                                                            #
#   07. Extras                                                                                                #
###############################################################################################################

###############################################################################################################
# 01. Non-Interactive Handling                                                                                #
###############################################################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

###############################################################################################################
# 02. History                                                                                                 #
###############################################################################################################

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

###############################################################################################################
# 03. Some good Mods                                                                                          #
###############################################################################################################

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

###############################################################################################################
# 04. Prompt Customization                                                                                    #
###############################################################################################################

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# Comment for a non-colored prompt, if the terminal has the capability; turned
# Off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
# Check if we have color-support
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
# Custom colors for prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[32m\]\u\[\e[0m\]:\[\e[02;34m\]\w\[\e[0m\]\[\e[93m\]\$\[\e[0m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

###############################################################################################################
# 05. Aliases                                                                                                 #
###############################################################################################################

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

###############################################################################################################
# 06. Completion                                                                                              #
###############################################################################################################

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################################################
# 07. Extras                                                                                                  #
###############################################################################################################

# None as of Now
