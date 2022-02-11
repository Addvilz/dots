export ZSH=~/.oh-my-zsh

if ! [ -d "$ZSH" ]; then
  echo "oh-my-zsh not present"
  return
fi

if ! type "micro" > /dev/null; then
  export EDITOR='vim'
else
  export EDITOR='micro'
fi

export VISUAL=$EDITOR

ZSH_THEME="gallois"

plugins=(git git-extras python pip sudo systemd wd command-not-found zsh-interactive-cd)

export PATH=${HOME}/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

source $ZSH/oh-my-zsh.sh

alias l="ls -lAFh --color=always --group-directories-first"
alias gogogadget="ansible-playbook -i hosts site.yml -K"

# Functions
function cd {
    builtin cd "$@" && l
}

# https://gist.github.com/davejamesmiller/1965569
ask() {
    # https://djm.me/ask
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        print -nP "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

take-cwd-ownership() {
  CWD=`pwd`

  if [[ $CWD = "/" ]]; then
    echo 'Are you nuts?!'
  fi

  if ask "%{$FG[202]%}[danger]%F{reset} Do you want to take recursive ownership of directory %{$FG[202]%}\$CWD\%{$reset_color%} as $UID:$GID?" 'N'; then
    sudo chown -Rf $UID:$GID $CWD
  fi
}

test-video-feed-from-picture() {
  ffmpeg -loop 1 -re -i "${1}" -f v4l2 -vcodec rawvideo -pix_fmt yuv420p "${2}"
}

test-video-feed-from-video() {
  ffmpeg -re -i "${1}" -f v4l2 "${2}"
}

if [[ $UID == 0 || $EUID == 0 ]]; then
  export PS1="%{$fg[cyan]%}[%~% ]%{$FG[202]%}[root]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b "
fi

NIMDIR=`realpath -q ~/.nimble/bin`

if [[ -n "$NIMDIR" && -d $NIMDIR ]]; then
  export PATH=$NIMDIR:$PATH
fi

PYENVDIR=`realpath -q ~/.pyenv/bin`
if [[ -n "$PYENVDIR" && -d $PYENVDIR ]]; then
  export PATH="$PYENVDIR:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

CARGODIR=`realpath -q $HOME/.cargo/`
if [[ -n "$CARGODIR" && -d $CARGODIR ]]; then
  source $CARGODIR/env
fi

source /etc/zsh_command_not_found
