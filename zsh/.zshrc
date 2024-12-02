if [ -f ~/.profile ]; then
    . ~/.profile;
fi

export PATH=~/.local/bin:$PATH

autoload -U promptinit; promptinit
prompt pure

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# emacs mode
bindkey -e

# edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

alias v=nvim
alias vim=nvim
alias vi=nvim
alias nv=nvim
alias ls='exa'
alias la='exa -la'

source ~/.config/zsh/plugins/zsh-z.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
