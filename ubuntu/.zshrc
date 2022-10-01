export ZSH="$HOME/.zsh"


plugins=(
	git
	docker
	kubectx
	kubectl
	z
)

# Source custom init
source $ZSH/init.sh

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

eval "$(starship init zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source $ZSH/zsh-plugins/custom/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-plugins/custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# End of lines added by compinstall
#
# For a full list of active aliases, run `alias`.

# aliases
alias zshconfig="nvim ~/repos/dotprofiles/ubuntu/.zshrc"
alias tf=terraform
alias cat=batcat
alias nv=nvim

# # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

complete -F __start_terraform tf
complete -F __start_kubectl k


# Make fzf default to ripgrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi


# Load custom functions from .zshfn
fpath=( ~/.zshfn "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Other exports
export EDITOR=nvim
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/$USER/go/bin/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
