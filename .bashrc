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

eval "$(zoxide init bash)"

alias dv='git diff --name-only | xargs nvim'
alias lg="lazygit"

export PATH="$PATH:/opt/nvim-linux64/bin"
