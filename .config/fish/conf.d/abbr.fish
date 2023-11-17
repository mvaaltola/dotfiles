abbr -a vimconf nvim ~/.config/nvim/init.vim
abbr -a fishconf nvim ~/.config/fish
abbr -a sxconf nvim ~/.config/sxhkd/sxhkdrc

abbr -a cd cl
abbr -a ls eza
abbr -a la eza -alh
abbr -a ll eza -lh
abbr -a vim nvim
abbr -a vi nvim
abbr -a v nvim
abbr -a :q exit
abbr -a cfg dotbare
abbr -a tp trash-put

abbr -a ssh kitty +kitten ssh

abbr -a g git
abbr -a ga git add
abbr -a gap git add -p
abbr -a gch git switch
abbr -a gr git restore
abbr -a grs git restore --staged
abbr -a gbr git branch 
abbr -a gre git rebase
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gs git status --short --branch
abbr -a gss git status
abbr -a gst git stash
abbr -a gsw git switch
abbr -a gl git slog
abbr -a glf git log --pretty=fuller
abbr -a gll git log -p
abbr -a gc git commit
abbr -a gca git commit --amend --no-edit
abbr -a gcar git commit --amend
abbr -a gcan git commit --amend --no-edit --date=now
abbr -a gm git merge --no-ff
abbr -a gundo git reset --soft HEAD~1
abbr -a gP git push --set-upstream
abbr -a gPF git push -f
abbr -a gp git pull

abbr -a d docker
abbr -a dc docker compose
abbr -a dcr "docker compose down && docker compose up -d"
abbr -a dcrf "docker compose down --volumes --remove-orphans && docker compose up -d"
abbr -a dcd "docker compose down --volumes --remove-orphans"
abbr -a dcu "docker compose up -d"

abbr -a ppo "paru -Syu --noconfirm && printf '\n\nshutting down in 15s\n\n' && sleep 15 && poweroff"
abbr -a pinst pacman -Qent
abbr -a pdeps pacman -Qdqt

abbr -a k kubectl
