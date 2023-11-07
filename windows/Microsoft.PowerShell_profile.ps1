oh-my-posh --init --shell pwsh --config C:/Users/nbn/scoop/apps/oh-my-posh/current/themes/slimfat.omp.json | Invoke-Expression
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# autojump
Import-Module ZLocation;
Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"
Set-Alias -Name j -Value Invoke-ZLocation
Set-Alias -Name vim -Value nvim

# kubectl staging
function kbs($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) {
    kubectl --context=gke_agency-revolution_asia-southeast1-a_staging-v2 --namespace=staging-v2 $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}

#kubectl production
function kbp($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) {
    kubectl --context=gke_agency-revolution_us-west1-b_production-v2 --namespace=production-v2 $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}

function glog {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

function gs {
    git status
}

function gd {
    git diff
}

function gco($1){
    git checkout $1
    & invoke-Expression 'git checkout $1'
}

function gcurrent() {
  & invoke-Expression 'git branch | sed -n "/\* /s///p"' 2>&1
}

function gpull {
    $branch = & invoke-Expression gcurrent 2>&1
    "git pull origin $branch --rebase"
    git pull origin $branch --rebase
}

function gpush() {
    $branch = & invoke-Expression gcurrent 2>&1
    "Current git branch $BRANCH"
    git push origin $BRANCH
}

function gpushf() {
    $branch = & invoke-Expression gcurrent 2>&1
    "Current git branch $BRANCH"
    git push origin $BRANCH -f
}

function gcommit($1) {
  $BRANCH = & invoke-Expression gcurrent 2>&1
  "Current git branch $BRANCH"

  "git add --all"
  git add --all

  "git commit -m $1"
  git commit -m $1
  # & invoke-Expression "git commit -m $1" 2>1

  "git push origin $BRANCH"
  git push origin $BRANCH
}

function grebase() {
    $CURRENT_BRANCH = & invoke-Expression gcurrent 2>&1
    $BASE_BRANCH="master"

    "> Current git branch $CURRENT_BRANCH"
    git checkout $BASE_BRANCH

    "> git pull origin $BASE_BRANCH --rebase"
    git pull origin $BASE_BRANCH --rebase

    "> git checkout $CURRENT_BRANCH"
    git checkout $CURRENT_BRANCH

    "> git rebase $BASE_BRANCH"
    git rebase $BASE_BRANCH
}

function gmerge() {
  $CURRENT_BRANCH = & invoke-Expression gcurrent 2>&1
  $TO_BRANCH="master"

  "> Merging $CURRENT_BRANCH -> $TO_BRANCH"

  "> git checkout $TO_BRANCH"
  git checkout $TO_BRANCH

  "> git merge --no-ff $CURRENT_BRANCH"
  git merge --no-ff $CURRENT_BRANCH

  "> git commit -m 'Merge branch $CURRENT_BRANCH'"
  git commit -m "Merge branch $CURRENT_BRANCH"

  "> git push origin $TO_BRANCH"
  git push origin $TO_BRANCH

  "> Delete $CURRENT_BRANCH branch from local"
  git branch -D $CURRENT_BRANCH
}

function gtag($1) {
    $cmd1="git tag --sort=taggerdate | grep $1 | tail -n 100"
    $tags = & invoke-Expression $cmd1 2>&1
    $cmd2="node $env:CONNECT_APP_DIR/deployment/scripts/tools/calculate-latest-git-tag.js $tags"
    $result = & invoke-Expression $cmd2 | Out-String
    "$result"
}

function gtagpush($1) {
    "> git checkout master"
    git checkout master

    "> git tag -a $1 -m `"$1`""
    git tag -a $1 -m "$1"

    "> git push origin $1"
    git push origin $1
}

function gstg(){
    gcloud compute instances list | grep staging-v2-fuse-cloud-pool | awk 'NR==1 {print $4}' | set-clipboard
    sudo nvim C:\Windows\System32\drivers\etc\hosts
}

[System.Environment]::SetEnvironmentVariable('NODE_EXE','C:\Users\nbn\scoop\persist\nvm\nodejs\v12.12.0\node.exe')
[System.Environment]::SetEnvironmentVariable('INFLUX_TOKEN','J65ksD3POuXwtNwYX_iA0pPGoagUMIYRTA0eIWbotha3ypmFzYoxJWXYQB6sFRFiZPGD8G-BA4CVhh4lIPeUxw==')
