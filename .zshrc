# Include configuration specific for this machine
source ~/.zshrc_local

# Use 'pure' zsh theme
# https://github.com/sindresorhus/pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:prompt:success color '#5df542' 
zstyle :prompt:pure:prompt:error color '#ff0000'
zstyle :prompt:pure:path color '#c685ff' 

# Add aliases
alias e="subl -a" # Open text editor of choice 
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
alias greset-origin='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gupdate='git fetch && greset-origin && gsupdate && echo && gs'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# fzf setup
source <(fzf --zsh)

# Prevent cd from going to home directory when it is supplied no arguments
cd() {
  [[ $# -eq 0 ]] && return
    builtin cd "$@"
}

# Save every command to history before executing 
setopt inc_append_history

# Wrapper allows a custom editor to be called for only the edit-command-line
edit_command_line_wrapper() {
  # Save the current value of $EDITOR
  local original_editor="$EDITOR"

  # Set a new editor for this session (e.g., Sublime Text)
  export EDITOR="subl -w -a"

  # Call the original edit-command-line widget
  zle edit-command-line

  # Restore the original $EDITOR value after editing
  export EDITOR="$original_editor"
}
zle -N edit_command_line_wrapper

# Set up Ctrl-O to edit the current command with the wrapper
# To use the native edit-command-line, replace edit_command_line_wrapper
# with edit-command-line in the following line
bindkey "^O" "edit_command_line_wrapper"
# Load edit-command-line (zsh command) once
autoload -z edit-command-line
zle -N edit-command-line

export EDITOR="subl -a -w"

# Do not close the shell on EOF signals (Ctrl+d)
# If 10 are sent, the shell will be closed regardless
setopt ignore_eof
