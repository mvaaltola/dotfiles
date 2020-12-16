# oh-my-zsh config - template at https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
export ZSH=/usr/share/oh-my-zsh
ZSH_THEME="zeta"
plugins=(
    git
    colored-man-pages
    gitignore
    fasd
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
)
source $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/hist
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mikael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# add local bin to PATH
export PATH=$PATH:~/.local/bin

# use lf to move around dirs
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# node/npm packages path
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# nvm
# nvm() {
    # unset -f nvm
    # export NVM_DIR=~/.nvm
    # [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    # nvm "$@"
# }
# 
# node() {
    # unset -f node
    # export NVM_DIR=~/.nvm
    # [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    # node "$@"
# }
# 
# npm() {
    # unset -f npm
    # export NVM_DIR=~/.nvm
    # [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    # npm "$@"
# }

# ls after cd
function chpwd() {
    emulate -L zsh
    exa -a
}

# docker clean functions
function removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

function armageddon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

# less config
export PAGER="less"
export LESS="S R"

# keybinds
bindkey -s  '^o' 'lfcd\n'
bindkey "^[[1;5C" forward-word # ctrl-right
bindkey "^[[1;5D" backward-word # ctrl-left
bindkey "^[[A" history-substring-search-up # up
bindkey "^[[B" history-substring-search-down # down
bindkey -s "^k" 'cd ..\n'

eval $(thefuck --alias)
alias zshconf="vim ~/.config/zsh/.zshrc"
alias i3conf="vim ~/.config/i3/config"
alias vimconf="nvim ~/.config/nvim/init.vim"
alias ls="exa"
alias la="exa -alh"
alias vim="nvim"
alias d="dotbare"

# dotbare install
alias dotbare="/opt/dotbare/dotbare"
# export DOTBARE_DIR="$HOME/.config/dotbare"
# export DOTBARE_TREE="/"

export DOTBARE_DIR="$HOME/.config/dotfiles"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
function condainit() {
    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}
# <<< conda initialize <<<

