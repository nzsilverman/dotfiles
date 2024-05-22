# Use 'pure' zsh theme
# https://github.com/sindresorhus/pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:prompt:success color '#5df542' 
zstyle :prompt:pure:prompt:error color '#ff0000'
zstyle :prompt:pure:path color '#c685ff' 

# Add aliases
alias v="vim"
alias refresh-zsh='source ~/.zshrc'
alias gamend='git commit --amend --no-edit'
alias gaddamend='git add . && git commit --amend --no-edit'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gforce='git push --force-with-lease'
alias grebase-master='git fetch origin master && git rebase'
alias gsupdate='git submodule update --init --recursive'
alias pactivate='source env/py*/bin/activate'
alias grm-not-master='git checkout master | git branch | grep -v "master" | xargs git branch -D'
alias grm-not-main='git checkout main | git branch | grep -v "main" | xargs git branch -D'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# fzf setup
source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Prevent cd from going to home directory when it is supplied no arguments
cd() {
  [[ $# -eq 0 ]] && return
    builtin cd "$@"
}

# Save every command to history before executing 
setopt inc_append_history


# Include configuration specific for this machine
source ~/.zshrc_local
