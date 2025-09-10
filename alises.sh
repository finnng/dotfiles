alias ll="ls -al"
alias vim="nvim"
alias c="chatgpt"

alias gdiff='vim -p $(git diff --name-only) -c "tabdo :Gvdiff HEAD"'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gc="git checkout"
alias gd="git diff"
alias gs="git status"
alias gb="git for-each-ref --sort=-creatordate --format '%(refname:short)' refs/heads | fzf --no-sort | xargs git checkout"

# search in the history
h() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

dotsync() {
  rsync -r ~/.config/nvim/* ~/projects/dotfiles/nvim
  rsync -r ~/.config/karabiner/* ~/projects/dotfiles/karabiner
  rsync -r ~/.config/kitty/* ~/projects/dotfiles/kitty
  rsync -r ~/aliases.sh ~/projects/dotfiles/alises.sh
  rsync -r ~/.zshrc ~/projects/dotfiles/zshrc.sh
  rsync -r ~/.tmux.conf ~/projects/dotfiles/tmux.conf
}

function dashcase() {
  local str=$1
  str=$(echo "$str" | tr '[:upper:]' '[:lower:]') # Converts the string to lowercase
  str=${str// /-}                                 # Replaces all spaces with undercore
  str=${str//\'/}                                 # Removes all single quotes
  str=${str//\"/}                                 # Removes all double quotes
  echo "$str"
  echo "$str" | pbcopy
}

export TIP="192.168.68.126"
alias k="kubectl"
alias t="talosctl"
alias kt="kubectl --context=admin@talos-default-1"
