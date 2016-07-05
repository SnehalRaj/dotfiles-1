# Path to your oh-my-zsh installation.
export ZSH=~/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="yashpl"


# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/dotfiles/zsh-custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bower catimg colored-man-pages colorize command-not-found cp debian docker emoji-clock gem git httpie npm pip sbt scala sudo web-search wd zsh-syntax-highlighting)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/yash/bin:/usr/local/share/scala/bin:/home/yash/git/arcanist/bin:/usr/local/lib:."
export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
export JAVA_LIBRARY_PATH="/usr/local/lib"
export LD_LIBRARY_PATH=/usr/local/lib
# export MANPATH="/usr/local/man:$MANPATH"

source /etc/profile.d/perlbin.sh

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
#export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt nomatch

# Run ScreenFetch and fortune on start
if [ -f /usr/bin/screenfetch -o -f /bin/screenfetch ]; then
  fortune -s
  echo ''
  tput rmam
  printf '\033[?7l'
  screenfetch
  printf '\033[?7h'
  tput smam
elif [ -f ~/dotfiles/screenfetch ]; then
  fortune -s
  echo ''
  tput rmam
  printf '\033[?7l'
  ~/dotfiles/screenfetch
  printf '\033[?7h'
  tput smam
fi

BROWSER=iceweasel
export COOKIE="Cookie:auth=37441B2C54EE6C43875DCAA60BBD7F228C149CA9; timestamp=1465921399; id=yashsriv"
export COOKIE2="Cookie:auth=F804E2CC867278D2D42ABCEEE34FE5B388236662; timestamp=1466108340; id=srivyash2"

export ARCHCOOKIE="Cookie:auth=602B1692141F8A94329FDDC820E532EAC672A679; timestamp=1466680544; id=yashsriv"
export ARCHCOOKIE2="Cookie:auth=0F89CC891030C76D7ABF8794C8880971CAA733FF; timestamp=1466680667; id=srivyash"

export GMANTRA="Cookie:auth=449BCF3E4C74A1400090DA4D372F3FD45462E032; timestamp=1467121036; id=qwerty"
