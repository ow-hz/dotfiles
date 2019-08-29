#################################################
#                                               #
# My customized settings                        #
#                                               #
#################################################
export LC_ALL=en_US.UTF-8

alias tmux="tmux -2 -f ~/.dotfiles/tmux.conf"

plugins=(git)

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# compile using brewed openssl
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)";
fi

# docker
if command -v docker-machine 1>/dev/null 2>&1; then
  if [ "$(docker-machine status 2>/dev/null)" = "Running" ]; then
    eval $(docker-machine env)
  fi
fi

# pipenv
if command -v pipenv 1>/dev/null 2>&1; then
  export PIPENV_VENV_IN_PROJECT=yes
fi

linkBrewedPython3() {
  if command -v brew 1>/dev/null 2>&1; then
    p=$(brew --cellar python)
    if [ -e $p ]; then
      for i in `ls $p`; do
        ln -s $p/$i/ $PYENV_ROOT/versions/$i-brew;
	if [ $? -eq 0 ]; then
          echo "$i linked to pyenv!"
	fi
      done
    fi
  else
    echo "Homebrew is not installed!"
  fi
}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
