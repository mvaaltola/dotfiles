export ZSH=/usr/share/oh-my-zsh
ZSH_THEME="zeta"
plugins=(
    colored-man-pages
    git
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

# Add local bin to PATH
export PATH=$PATH:~/.local/bin
# Add ~/x to PATH
export PATH=$PATH:~/x

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# load pywal colorscheme
(cat ~/.cache/wal/sequences &)
# source ~/.cache/wal/colors.sh

# vim keybinds
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# ls after cd

function chpwd() {
    emulate -L zsh
    ls -a
}

# keybinds
bindkey -s  '^o' 'lfcd\n'
bindkey "^[[1;5C" forward-word # ctrl-right
bindkey "^[[1;5D" backward-word # ctrl-left
bindkey "^[[A" history-substring-search-up # up
bindkey "^[[B" history-substring-search-down # down
bindkey -s "^k" 'cd ..\n'

# nvm initialization
function nvminit() {
    export NVM_DIR="$HOME/.local/share/nvm"
    source /usr/share/nvm/nvm.sh
    source /usr/share/nvm/bash_completion
    source /usr/share/nvm/install-nvm-exec
}

# Conda initialization

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

