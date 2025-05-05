# promp UI
PROMPT_COMMAND='
  PS1_CMD1=$(git branch --show-current 2>/dev/null)
  if [ -n "$PS1_CMD1" ]; then
    PS1_BRANCH=" \[\e[32m\](${PS1_CMD1})\[\e[0m\]"
  else
    PS1_BRANCH=""
  fi
  PS1="\[\e[34m\]\w\[\e[0m\]${PS1_BRANCH}\n\[\e[32m\]\$\[\e[0m\] "
'

# brew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias
alias lsa='ls -A'
alias l='ls -l'
alias ll='ls -la'
