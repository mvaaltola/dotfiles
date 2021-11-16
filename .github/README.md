# dotfiles

various dotfiles and configs.

this is a bare repo, the root of the repository is at `$HOME`.

## installation

the easiest way to install is by using [dotbare](https://github.com/kazhala/dotbare).

first, set the following:
```
export DOTBARE_DIR="$HOME/.config/dotfiles"
```

to install the dotfiles using dotbare, run:
```
dotbare finit -u https://github.com/mvaaltola/dotfiles.git
```

## testing

dotbare can also be tested in docker:
```
docker pull kazhala/dotbare:latest
docker container run -it -rm --name dotbare kazhala/dotbare:latest
```
