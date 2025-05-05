PROMPT_COMMAND='
  PS1_CMD1=$(git branch --show-current 2>/dev/null)
  if [ -n "$PS1_CMD1" ]; then
    PS1_BRANCH=" \[\e[32m\](${PS1_CMD1})\[\e[0m\]"
  else
    PS1_BRANCH=""
  fi
  PS1="\[\e[34m\]\w\[\e[0m\]${PS1_BRANCH}\n\[\e[32m\]\$\[\e[0m\] "
'
eval "$(/opt/homebrew/bin/brew shellenv)"

alias ls='lsd'
alias lsa='lsd -A'
alias l='lsd -la'
alias ll='lsd -l'
