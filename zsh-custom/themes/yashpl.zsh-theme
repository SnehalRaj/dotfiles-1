# vim:ft=zsh ts=2 sw=2 sts=2

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
    echo -n " %{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment 154 16 "%(!.%{%F{yellow}%}.)%n"
  fi
}
# Git: branch/detached head, dirty status
prompt_git() {
  # Must use Powerline font, for \uE0A0 to render.
  if [[ -n "$SSH_CLIENT" ]]; then
    ZSH_THEME_GIT_PROMPT_PREFIX=""
  else
    ZSH_THEME_GIT_PROMPT_PREFIX="\uE0A0 "
  fi
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY="!"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    if [[ -n $dirty ]]; then
      prompt_segment 214 16
    else
      prompt_segment 112 16
    fi
    echo -n $(git_prompt_info)
  fi
}
# Dir: current working directory
prompt_dir() {
  prompt_segment 16 154 '%c'
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
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment 16 default "$symbols"
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
        color=202
        symbol="\u231B"
      else
        color=208
        symbol="\u26A0"
      fi
    else
      symbol="\u26A1"
      color=38
    fi
    prompt_segment_backwards $color 16 "$symbol $(battery_charge)"
  fi
}

# Time:
# - Clock Symbol
# - Current time
prompt_time() {
  local symbols
  symbols=()
  [[ -n $SSH_CLIENT ]] && symbols+="⌚"

  prompt_segment_backwards 197 default "$symbols %*"
}

## R prompt
build_r_prompt() {
  prompt_battery
  prompt_time
  prompt_end_backwards
}

RPROMPT='%{%f%b%k%}$(build_r_prompt) '
