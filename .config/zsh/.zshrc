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

# ls after cd
function chpwd() {
    emulate -L zsh
    exa -a
}

# keybinds
bindkey -s  '^o' 'lfcd\n'
bindkey "^[[1;5C" forward-word # ctrl-right
bindkey "^[[1;5D" backward-word # ctrl-left
bindkey "^[[A" history-substring-search-up # up
bindkey "^[[B" history-substring-search-down # down
bindkey -s "^k" 'cd ..\n'

