# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# editor
export EDITOR='nvim'
export VISUAL='nvim'

# path
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/.humanlog/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PNPM_HOME:$PATH:/opt/nvim-linux-x86_64/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# yazi: launch with `y`, and cd to the last dir on quit
function y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# aliases
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias nv='nvim'
alias tm='tmux'
alias claudes='tmux attach -t claude'
alias pull='git pull'
