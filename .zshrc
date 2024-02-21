export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

plugins=(
  git
  docker
  kubectx
  kubectl
  gh
  fzf
  z
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-interactive-cd
  zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
unsetopt BEEP

# End of lines added by compinstall
#
# For a full list of active aliases, run `alias`.

# aliases
# alias cat=batcat

alias python=python3
alias nv=nvim
alias k=kubectl
alias tf=terraform
alias kns=kubens
alias ktx=kubectx
alias conf="nvim ~/.zshrc"
alias kaf="kubectl apply -f"

# Make fzf default to ripgrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

 # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

complete -F __start_terraform tf
complete -F __start_kubectl k

# Change comment style from dark blue to green
ZSH_HIGHLIGHT_STYLES[comment]=fg=green,bold
# Change suggestion highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#555555'

# Other exports
export EDITOR=nvim
export PATH=$PATH:/usr/local/go/bin:/$HOME/go/bin
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$HOME/.tools
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If asdf, then initialize
# . "$HOME/.asdf/asdf.sh"

autoload -U +X bashcompinit && bashcompinit
