# vim:ft=zsh ts=2 sw=2 sts=2

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
function dollar {
  if [[ $? -ne 0 ]]; then
    echo Error$?
    echo "%{$fg[magenta]%}$%{$reset_color%}"
  else
    echo "%{$fg[yellow]%}$%{$reset_color%}"
  fi
}
if [[ -n "$SSH_CLIENT" ]]; then
  RPROMPT='$(battery_level_ssh)''%% %{$fg_bold[red]%}%*%{$reset_color%}'
  ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[magenta]%}"
else
  RPROMPT='$(battery_is_charging)'' $(battery_charge)''%{$reset_color%}'' ⌚ ''%{$fg_bold[red]%}%*%{$reset_color%}'
  ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[magenta]%}\uE0A0"
fi

PROMPT='%{$fg[green]%}%n%{$reset_color%}:%{$fg[blue]%}%c%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%(!.#.$)%{$reset_color%} '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
