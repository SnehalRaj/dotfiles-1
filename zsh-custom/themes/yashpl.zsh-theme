# vim:ft=zsh ts=2 sw=2 sts=2
# Heavily inspired by nojhan/liquidprompt

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters

() {
local LC_ALL="" LC_CTYPE="en_US.UTF-8"
# NOTE: This segment separator character is correct.  In 2012, Powerline changed
# the code points they use for their special characters. This is the new code point.
# If this is not working for you, you probably have an old version of the
# Powerline-patched fonts installed. Download and install the new version.
# Do not submit PRs to change this unless you have reviewed the Powerline code point
# history and have new information.
# This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
# what font the user is viewing this source code in. Do not replace the
# escape sequence with a single literal character.
# Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
SEGMENT_SEPARATOR=$'\ue0b0'
SEGMENT_SEPARATOR_BACKWARDS=$'\ue0b2'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Rprompt Additions
# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment_backwards() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{%F{$1}%K{$CURRENT_BG}%}$SEGMENT_SEPARATOR_BACKWARDS%{$fg$bg%}"
  else
    echo -n "%{%F{$1}%K{$2}%}$SEGMENT_SEPARATOR_BACKWARDS%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end_backwards() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
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
        prompt_segment default 16 "%(!.%{%F{red,bold}%}.)%n$HOST"
      else
        prompt_segment 154 16 "%(!.%{%F{red,bold}%}.)%n$HOST"
      fi
    fi
  fi
}
# Git: branch/detached head, dirty status
prompt_git() {
  # Must use Powerline font, for \uE0A0 to render.
  if [[ -n "$SSH_CLIENT" ]]; then
    GIT_PROMPT_PREFIX=""
  else
    GIT_PROMPT_PREFIX="\uE0A0 "
  fi
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
      BRANCH=$BRANCH[0,5]
    fi
    if [[ ! "${bits}" == "" ]]; then
      prompt_segment 214 16 "$GIT_PROMPT_PREFIX$BRANCH$bits"
    else
      prompt_segment 154 16 "$GIT_PROMPT_PREFIX$BRANCH$bits"
    fi
  fi
}
# Dir: current working directory
prompt_dir() {
  prompt_segment 234 154 '%c'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=""
  local -i r s
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘ "
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡ "
  local -i detached=0
  detached+=$(tmux list-sessions 2> /dev/null | \grep -cv 'attached')
  (( detached > 0 )) && symbols+="%{%F{154}%}${detached}⑂ "
  if (( r = $(jobs -r | wc -l) )); then
    symbols+="%{%F{cyan}%}${r}⚙ "
  fi
  if (( s = $(jobs -s | wc -l) )); then
    symbols+="%{%F{yellow}%}${s}💤"
  fi

  if [[ $(tput cols) -ge 125 ]]; then
    [[ -n "$symbols" ]] && prompt_segment 234 234 "$symbols"
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

###RPROMPT Components

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
echo %{$fg[$color]%}$(battery_level)%%
}
function battery_is_charging() {
if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]]; then
  symbol=''
  if [ $(battery_level) -ge 40 ]; then
    color=green
    symbol="\u2615"
  elif [ $(battery_level) -ge 20 ]; then
    color=yellow
    symbol="\u231B"
  else
    color=red
    symbol="\u26A0"
  fi
else
  symbol="\u26A1"
  color=magenta
fi
echo %{$fg_bold[$color]%}$symbol
}

# Battery
prompt_battery() {
  if [[ -n "$SSH_CLIENT" ]]; then
    battery_level_ssh
  else
    if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]]; then
      if [ $(battery_level) -ge 40 ]; then
        color=118
        symbol="\u2615"
      elif [ $(battery_level) -ge 20 ]; then
        color=208
        symbol="\u231B"
      else
        color=196
        symbol="\u26A0"
      fi
    else
      symbol="\u26A1"
      color=38
    fi
    if [[ $(tput cols) -gt 125 ]]; then
      prompt_segment_backwards $color 234 "$symbol $(battery_charge)"
    elif [[ $(battery_level) -ge 20 ]]; then
      prompt_segment_backwards $color 234 "$symbol"
    else
      prompt_segment_backwards $color 234 "$symbol $(battery_level)%%"
    fi
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
    prompt_segment_backwards 234 197 " $symbols %*"
  else
    prompt_segment_backwards 234 197 " $symbols"
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
    prompt_segment_backwards 234 default "$symbol ⌂ ${load}%%"
  fi
}

## R prompt
build_r_prompt() {
  prompt_cpu
  prompt_battery
  prompt_time
  prompt_end_backwards
}

RPROMPT='%{%f%b%k%}$(build_r_prompt)'
