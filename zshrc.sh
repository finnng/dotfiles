export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
plugins=(git zsh-completions kubectl)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh


source ~/aliases.sh
source ~/fuse-ultils.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/bin
export PATH="$PATH:/Users/finn/.dotnet/tools"

export BAT_THEME="Nord"


export FZF_DEFAULT_OPTS='-m --height 80% --border --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
