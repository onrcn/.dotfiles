if [ -f ~/.profile ]; then
    . ~/.profile;
fi

eval "$(batman --export-env)"

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

autoload -U +X bashcompinit && bashcompinit

# emacs mode
bindkey -e

# edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

bindkey -s ^f "tmux-sessionizer\n"

alias v=nvim
alias vim=nvim
alias vi=nvim
alias nv=nvim
alias ls='eza'
alias la='eza -la'
alias se='sudoedit'
alias ec='emacsclient -nc"'
alias python='/usr/bin/python3'
alias gemini='gemini; stty sane' # for kitty to behave!

source ~/.config/zsh/plugins/zsh-z/zsh-z.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF Variables
FZF_ALT_C_COMMAND= source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
