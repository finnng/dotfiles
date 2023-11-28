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

function get_ticket_number() {
  local branch_name
  branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    echo ""
  else
    local ticket_number
    if [[ $branch_name =~ ^[a-zA-Z]+-[0-9]+-.*$ ]]; then
      ticket_number=$(echo $branch_name | awk -F- '{print $1"-"$2}')
      echo $ticket_number
    else
      echo ""
    fi
  fi
}

function ggm() {
  local git_changes
  local prompt="Generate a commit message that follows these best practices:
1. A concise subject line (50 characters or less) in the imperative mood.
2. Include a body that is separated from the subject by a blank line. The body should only consist of bullet points summarizing the changes.
3. The body should wrap at 72 characters.
4. Do not end the subject line with a period.
The output should only be the commit message, nothing else. Do not include any notes or additional text."

  git_changes=$(git diff)
  if [[ -n $git_changes ]]; then
    # Replace the following lines with your actual script to generate commit message
    chatgpt --clear-history
    chatgpt --set-model gpt-3.5-turbo-16k-0613
    commit_message=$(echo "$git_changes" | chatgpt "$prompt")

    # Remove existing quotes from commit message
    commit_message=${commit_message//\"/}

    local ticket_number
    ticket_number=$(get_ticket_number)
    if [[ -n $ticket_number ]]; then
      commit_message="\"$ticket_number: $commit_message\""
    fi

    echo "$commit_message"
    echo "$commit_message" | pbcopy
    echo "Commit message copied to clipboard."
  else
    echo "No changes detected in the git repository."
  fi
}
