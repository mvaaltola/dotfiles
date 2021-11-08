alias vimconf="nvim ~/.config/nvim/init.vim"

alias ls="exa"
alias la="ls -alh"
alias vim="nvim"
alias vi="nvim"
alias :q="exit"
alias cfg="dotbare"

abbr -a ssh = "kitty +kitten ssh"
abbr -a g git
abbr -a gch git checkout
abbr -a gbr git branch 
abbr -a gre git rebase
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gst git stash
abbr -a gsw git switch

abbr -a d docker
abbr -a dc docker-compose
abbr -a pdeps pacman -Qdqt
