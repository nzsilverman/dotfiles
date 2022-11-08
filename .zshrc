# Use 'pure' zsh theme
# https://github.com/sindresorhus/pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure


# Add aliases
alias v="vim"
alias refresh-zsh='source ~/.zshrc'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# fzf setup
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

# Modify Path
export PATH="/usr/local/lib:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Include configuration specific for this machine
source ~/.zshrc_local
