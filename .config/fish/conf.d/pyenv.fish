# pyenv setup

set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"

function pyenvinit
  pyenv init --path | source
  pyenv init - | source
  status --is-interactive; and pyenv-virtualenv-init - | source
end
