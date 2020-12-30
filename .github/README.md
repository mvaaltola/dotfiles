# dotfiles

various dotfiles and configs.

this is a bare repo, the root of the repository is at `$HOME`.

## dotbare

the easiest way to install is by using [dotbare](https://github.com/kazhala/dotbare).

set the following:
```
alias dotbare="/opt/dotbare/dotbare"
export DOTBARE_DIR="$HOME/.config/dotfiles"
```

## Installation

to install the dotfiles using dotbare, run:
```
dotbare finit -u https://github.com/mvaaltola/dotfiles.git
```

## Testing

dotbare can be tested in docker:
```
docker pull kazhala/dotbare:latest
docker container run -it -rm --name dotbare kazhala/dotbare:latest
```
