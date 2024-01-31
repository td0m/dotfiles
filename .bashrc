# let there be peace.
set -o emacs
export EDITOR=nvim

# /opt/homebrew/opt/fzf/install
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PS1="\w $ "

# garbage collection
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/bin:$PATH"

# zoom!
j() { cd $(find ${1:-.} -type d | fzf); }
p() { cd ~/p && cd $(find . -maxdepth 1 -type d | fzf); }

alias dv='git diff --name-only | xargs nvim'
alias lg="lazygit"
