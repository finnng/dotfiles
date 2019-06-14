export FZF_DEFAULT_COMMAND="ag --nogroup --nocolor --column --hidden -l"

alias ll="ls -al"

alias vim='~/nvim-osx64/bin/nvim'
alias vi='~/nvim-osx64/bin/nvim'

alias evim='vim ~/.vimrc'
alias eapi='cd ~/ringblaze/api && vim .'
alias eui='cd ~/ringblaze/ui && vim .'
alias emobi='cd ~/ringblaze/mobility && vim .'
alias ehippo='cd ~/projects/hippo && vim .'

alias salias="source ~/.bash_aliases"
alias ealias="vim ~/.bash_aliases"

alias dc="docker-compose"
alias dclog="docker-compose logs -f --tail=100"

alias ctags="`brew --prefix`/bin/ctags"

# Read markdown on terminal
rmd () {
  pandoc $1 | lynx -stdin
}

# Only show the current directory's name in the tab
#export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

################# GIT #################

alias gdiff='vim -p $(git diff --name-only) -c "tabdo :Gvdiff HEAD~1"'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# git status
function gs(){
  git status
}

function gck() {
  git checkout
}

# git delete all the local branchs
function gdb(){
  git branch | grep -v "master" | xargs git branch -D 
}

function gcurrent() {
  echo `git branch | sed -n "/\* /s///p"`
}

function gtemp() {
  git add --all
  git commit -m "Temp commit"
}

# ghotfix <message>
function ghotfix() {
  git add --all
  git commit -m "Hotfix: $1"
  gpush
}

# gcommit <message>
function gcommit() {
  BRANCH=$(gcurrent)
  echo "Current git branch $BRANCH"

  echo "git add --all ↩︎"
  git add --all

  echo "git commit -m \"$1\" ↩︎"
  git commit -m "$1"

  echo "git push origin $BRANCH ↩︎"
  git push origin $BRANCH
}

# gbranchrename <new-branch-name>
function gbranchrename() {
  OLD_BRANCH=$(gcurrent)
  NEW_BRANCH=$1
  echo "Rename git branch: $OLD_BRANCH --> $NEW_BRANCH"

  echo "git checkout master ↩︎"
  git checkout master

  echo "git branch -m $OLD_BRANCH $NEW_BRANCH ↩︎"
  git branch -m $OLD_BRANCH $NEW_BRANCH

  echo "git push origin :$OLD_BRANCH $NEW_BRANCH ↩︎"
  git push origin :$OLD_BRANCH $NEW_BRANCH
}

# gtagpush <tag-name>
function gtagpush() {
  git checkout master
  git tag -a $1 -m "v$1"
  git pull --prune origin master
  git push origin $1
}

# gtaglist <filter-string>
function gtaglist() {
  TAG_LIST=`git tag | grep $1`
  echo $TAG_LIST
}

# gtagdelete <branch-name>
function gtagdelete() {
  git tag -d $1
  git push origin :refs/tags/$1
}

# gfetch
function gfetch() {
  BRANCH=$(gcurrent)
  echo "git fetch --prune origin $BRANCH ↩︎"
  git fetch --prune origin $BRANCH
}

# gpull
function gpull() {
  BRANCH=$(gcurrent)
  echo "git pull --prune origin $BRANCH ↩︎"
  git pull --prune origin $BRANCH
}

# gpush
function gpush() {
  BRANCH=$(gcurrent)
  echo "Current git branch $BRANCH ↩︎"
  git push origin $BRANCH
}

# gpushf
function gpushf() {
  BRANCH=$(gcurrent)
  echo "Current git branch $BRANCH ↩︎"
  git push origin $BRANCH -f
}

# gbranchdelete <branch-name>
function gbranchdelete() {
  git push origin -d -f $1
  git branch -d $1
}

# gbranch <branch-name>
function gbranch() {
  git branch $1
  git checkout $1
  git push origin $1
}

# gstashrebase
function gstashrebase() {
  BRANCH=$(gcurrent)
  echo "Current git branch $BRANCH"
  git stash
  git checkout master
  git pull origin master
  git checkout $BRANCH
  git rebase master
  git stash apply
}

# grebase
function grebase(){
  BRANCH=$(gcurrent)
  TARGET="master"
  if [ ! -z $1 ]
  then
    TARGET=$1
  fi
  echo "Current git branch $BRANCH"
  echo "git checkout $TARGET ↩︎"
  git checkout $TARGET
  echo "git pull origin $TARGET ↩︎"
  git pull origin $TARGET
  echo "git checkout $BRANCH ↩︎" 
  git checkout $BRANCH
  echo "git rebase $TARGET ↩︎"
  git rebase $TARGET
}

# gmerge
function gmerge() {
  BRANCH=$(gcurrent)
  echo "Current git branch $BRANCH"

  echo "git checkout master"
  git checkout master

  echo "git merge --no-ff $BRANCH ↩︎"
  git merge --no-ff $BRANCH

  echo "git commit -m 'Merge branch $BRANCH' ↩︎"
  git commit -m "Merge branch $BRANCH"

  echo "git push origin master ↩︎"
  git push origin master
}

# git delete all local branches except master
function gdellocal(){
  echo "git branch | grep -v \"master\" | xargs git branch -D ↩︎"
  git branch | grep -v "master" | xargs git branch -D
}

################# END GIT #################
