# vim:ft=zsh ts=2 sw=2 sts=2

prompt_status() {
  local symbols
  symbols=""
  local -i r s
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}x "
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}§"
  local -i detached=0
  detached+=$(tmux list-sessions 2> /dev/null | \grep -cv 'attached')
  (( detached > 0 )) && symbols+="%{%F{154}%}${detached}d %{%f%k%b%}"
  if (( r = $(jobs -r | wc -l) )); then
    symbols+="%{%F{cyan}%}${r}& %{%f%k%b%}"
  fi
  if (( s = $(jobs -s | wc -l) )); then
    symbols+="%{%F{yellow}%}${s}z %{%f%k%b%}"
  fi

  if [[ $(tput cols) -ge 125 ]]; then
    [[ -n "$symbols" ]] && echo -n "$symbols"
  fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    echo -n "(`basename $virtualenv_path`)"
  fi
}

_connection() {
  if [[ -n "${SSH_CLIENT-}${SSH2_CLIENT-}${SSH_TTY-}" ]]; then
    echo ssh
  else
    local whoami="$(LANG=C who am i)"
    local sess_parent="$(ps -o comm= -p $PPID 2> /dev/null)"
    if [[ x"$whoami" != *'('* || x"$whoami" = *'(:'* || x"$whoami" = *'(tmux'* ]]; then
      echo lcl  # Local
    elif [[ "$sess_parent" = "su" || "$sess_parent" = "sudo" ]]; then
      echo su   # Remote su/sudo
    else
      echo tel  # Telnet
    fi
  fi
}
prompt_context() {
  HOST=""
  [[ -r /etc/debian_chroot ]] && HOST="($(< /etc/debian_chroot))"
  if [[ -n "$DISPLAY" ]]; then
    HOST="${HOST}%{%F{blue}%}@"
  else
    HOST="${HOST}@"
  fi

  case "$(_connection)" in
    ssh)
      HOST+="%{%F{57}%}%m"
      ;;
    su)
      HOST+="%{%F{97}%}%m"
      ;;
    tel)
      HOST+="%{%F{red}%}%m"
      ;;
    *)
      HOST=""
      ;;
  esac

  if [[ $(tput cols) -ge 125 ]]; then
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
      if [[ $UID -eq 0 ]]; then
        echo -n "%(!.%{%F{red,bold}%}.)%n$HOST:"
      else
        echo -n "%(!.%{%F{red,bold}%}.)%n$HOST:"
      fi
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n ' %{%F{green}%}%c%{%f%b%k%} '
}

# Git: branch/detached head, dirty status
prompt_git() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    STATUS=$(git status 2>&1 | tee)
    dirty=$(echo -n "$STATUS" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")
    untracked=$(echo -n "$STATUS" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")
    ahead=$(echo -n "$STATUS" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")
    newfile=$(echo -n "$STATUS" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")
    renamed=$(echo -n "$STATUS" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")
    deleted=$(echo -n "$STATUS" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")
    bits=""
    if [[ "$renamed" == "0" ]]; then
      bits+=">"
    fi
    if [[ "$ahead" == "0" ]]; then
      bits+="*"
    fi
    if [[ "$newfile" == "0" ]]; then
      bits+="+"
    fi
    if [[ "$untracked" == "0" ]]; then
      bits+="?"
    fi
    if [[ "$deleted" == "0" ]]; then
      bits+="x"
    fi
    if [[ "$dirty" == "0" ]]; then
      bits+="!"
    fi

    if [[ $(tput cols) -lt 125 ]]; then
      BRANCH=$BRANCH[0,6]
    fi
    if [[ "$ahead" == "0" ]]; then
      echo -n "[%{%F{226}%}$BRANCH$bits%{%f%b%k%}]"
    elif [[ ! "${bits}" == "" ]]; then
      echo -n "[%{%F{214}%}$BRANCH$bits%{%f%b%k%}]"
    else
      echo -n "[%{%F{154}%}$BRANCH$bits%{%f%b%k%}]"
    fi
  fi
}

# Cpu load
prompt_cpu() {
  local lp_cpu_load
  local eol
  read lp_cpu_load eol < /proc/loadavg
  cpunum=$( nproc 2>/dev/null || \grep -c '^[Pp]rocessor' /proc/cpuinfo )
  lp_cpu_load=${lp_cpu_load/./}   # Remove '.'
  lp_cpu_load=${lp_cpu_load#0}    # Remove leading '0'
  lp_cpu_load=${lp_cpu_load#0}    # Remove leading '0', again (ex: 0.09)
  local -i load=${lp_cpu_load:-0}/$cpunum
  if (( load > 65 )); then
    echo -n "⌂ ${load}%%"
  fi
}

# Time:
# - Clock Symbol
# - Current time
prompt_time() {
  local symbols
  symbols=""
  if [[ -n $SSH_CLIENT ]]; then
    symbols+=""
  else
    symbols+=`emoji-clock`
  fi

  if [[ $(tput cols) -gt 125 ]]; then
    echo -n " %{%F{197}%}$symbols  %*%{%f%b%k%}"
  else
    echo -n " %{%F{197}%}$symbols %{%f%b%k%}"
  fi
}

function battery_charge {
  echo `~/dotfiles/zsh.sh` 2>/dev/null
}
function battery_level {
  echo `acpi | grep -o "[0-9]*%" | sed 's/%$//'`
}
function battery_level_ssh() {
  if [ $(battery_level) -ge 40 ]; then
    color=green
  elif [ $(battery_level) -ge 20 ]; then
    color=yellow
  else
    color=red
  fi
  echo -n %{$fg[$color]%}⌁ $(battery_level)%% 
}

prompt_battery() {
  battery_level_ssh
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
}
PROMPT='%{%f%b%k%}$(build_prompt) $ '

build_r_prompt() {
  prompt_cpu
  prompt_battery
  prompt_time
}

RPROMPT='%{%f%b%k%}$(build_r_prompt) '
