if [ -f ~/.profile ]; then
    . ~/.profile;
fi

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
alias ls='eza'
alias la='eza -la'
alias se='sudoedit'
alias ec='emacsclient --create-frame'
alias python='/usr/bin/python3'

source ~/.config/zsh/plugins/zsh-z/zsh-z.plugin.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# FZF Variables
FZF_ALT_C_COMMAND= source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
