PROMPT='%{$fg[red]%}%*%{$reset_color%}%{$fg[cyan]%}$(command_time)%{$reset_color%} $(git_prompt_info)%{$fg[green]%}[${PWD/#$HOME/~}]%{$fg[yellow]%}λ%{$reset_color%} '

#RPROMPT='$(git_prompt_info)'
#RPROMPT='%{$fg[red]%}%*%{$reset_color%}'

zmodload zsh/datetime

ts_last=0

function preexec() {
    ts_last=$EPOCHREALTIME
}

function precmd() {
    if [[ $ts_last -ne 0 ]]; then
        execution_time=$((EPOCHREALTIME - ts_last))
	ts_last=0
    else
        execution_time=0
    fi
}

function command_time() {
  if (( execution_time > 0.5 ))
  then
    echo -n $ZSH_THEME_COMMAND_TIME_PREFIX
    time_to_human $execution_time
    echo -n $ZSH_THEME_COMMAND_TIME_SUFFIX
  fi
}

# Converts a floating point time in seconds to a human readable string.
function time_to_human() {
    seconds=$1
    if (( seconds < 10 )); then
      printf "%5.3fs" $seconds
    elif (( seconds < 60 )); then
      printf "%5.3fs" $seconds
    elif (( seconds < (60*60) )); then
      printf "%5.3fm" $(( seconds / 60 ))
    elif (( seconds < (60*60*24) )); then
      printf "%5.3fh" $(( seconds / (60*60) ))
    else
      printf "%5.3fd" $(( seconds / (60*60*24) ))
    fi
}

ZSH_THEME_COMMAND_TIME_PREFIX=" "
ZSH_THEME_COMMAND_TIME_SUFFIX=""
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}✱"
