alias ll="ls -al"
alias vim="nvim"
alias c="chatgpt"

alias gdiff='vim -p $(git diff --name-only) -c "tabdo :Gvdiff HEAD"'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gc="git checkout"
alias gd="git diff"
alias gs="git status"
alias gb="git branch | fzf | tr -d '[:space:]' | pbcopy"

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
}

function dash-case() {
  local str=$1
  str=$(echo "$str" | tr '[:upper:]' '[:lower:]') # Converts the string to lowercase
  str=${str// /-}                                 # Replaces all spaces with undercore
  str=${str//\'/}                                 # Removes all single quotes
  str=${str//\"/}                                 # Removes all double quotes
  echo "$str" | pbcopy
}

function ggm() {
  local git_changes
  local prompt="Generate a commit message for the following changes. Only output the message inside the double quotes. Do not say anything else. The message need to be short, decriptive, split by ; if it including many actions. Sort by the importance of actions"
  git_changes=$(git diff)
  if [[ -n $git_changes ]]; then
    commit_message=$(echo "$git_changes" | chatgpt "$prompt")
    echo "$commit_message"
    echo "$commit_message" | pbcopy
    echo "Commit message copied to clipboard."
  else
    echo "No changes detected in the git repository."
  fi
}
