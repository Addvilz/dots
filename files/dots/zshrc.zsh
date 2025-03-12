export OH_MY_ZSH_BASE_DIR=~/.oh-my-zsh

if ! [ -d "$OH_MY_ZSH_BASE_DIR" ]; then
  echo "oh-my-zsh installation directory does not exist - ${OH_MY_ZSH_BASE_DIR}"
  return
fi

if ! type "micro" >/dev/null; then
  export EDITOR='vim'
else
  export EDITOR='micro'
fi

export VISUAL=$EDITOR

# shellcheck disable=SC2034
ZSH_THEME='gallois'

# shellcheck disable=SC2034
plugins=(git git-extras wd zsh-interactive-cd)

export PATH=${HOME}/.bin:${HOME}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

source $OH_MY_ZSH_BASE_DIR/oh-my-zsh.sh

alias l='ls -lAFh --color=always --group-directories-first'
alias mux='tmuxinator'

# Functions
function rok {
  ssh -A rok.lab.lan
}

function rokx {
  ssh -A rok.lab.lan -t "tmux new-session -A -s remote"
}

function cd {
  builtin cd "$@" && l
}

# `pod python` gives the latest Python in the current directory
# I can't be bothered to install all the stuff on the host, frankly...
function pod {
  IMAGE='fedora'
  if [[ $# -ge 1 ]]; then
    IMAGE="$1"
    shift
  fi

  if [[ ! $IMAGE = *":"* ]]; then
    IMAGE="${IMAGE}:latest"
  fi

  WORKDIR=$(pwd)

  if [[ $# -eq 0 ]]; then
    set -- '/bin/bash' "$@"
  fi

  podman run \
    --pull=newer \
    --rm \
    -ti \
    -P \
    --entrypoint="" \
    -v "${WORKDIR}":/host:z \
    -w /host \
    "$IMAGE" \
    "$@"
}

function podd {
  WORKDIR=$(pwd)

  podman run \
    --pull=newer \
    --rm \
    -ti \
    -P \
    --entrypoint="" \
    -v "${WORKDIR}":/host:z \
    -w /host \
    "$@"
}

if [[ $UID == 0 || $EUID == 0 ]]; then
  export PS1="%{$fg[cyan]%}[%~% ]%{$FG[202]%}[root]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b "
fi

export PS1="%{%F{39}%}[%M]%F{default}$PS1"

zstyle ':completion::complete:make::' tag-order targets variables

export GPG_TTY=$TTY
