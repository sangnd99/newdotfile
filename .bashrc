if [ -f "$HOME/git-prompt.sh" ]; then
  source "$HOME/git-prompt.sh"
else
  curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

export PS1='\[\e[32m\]\w\[\e[0m\]$(__git_ps1 " (%s)")\n❯ '
