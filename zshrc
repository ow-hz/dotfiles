#################################################
#                                               #
# My customized settings                        #
#                                               #
#################################################
export LC_ALL=en_US.UTF-8

# pyenv
export PYENV_ROOT=$HOME/.pyenv

export PATH=$PYENV_ROOT/bin:$PATH



function link_brew_python3() {
    if command -v brew 1>/dev/null 2>&1
    then
        p=$(brew --cellar python)
        if [ -e $p ]
        then
            for i in $(ls $p)
            do
                ln -s $p/$i/ $PYENV_ROOT/versions/$i-brew
                if [ $? -eq 0 ]
                then
                    echo "$i linked to pyenv!"
                fi
            done
        fi
    else
        echo "Homebrew is not installed!"
    fi
}

plugins=(git)

# ZSH source
files=(
    /usr/local/etc/profile.d/autojump.sh
    /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)

for i in $files
do
    if [ -f $i ]
    then
        source $i
    fi
done


if command -v pyenv 1>/dev/null 2>&1
then
    eval "$(pyenv init -)"
fi


if command -v pyenv-virtualenv-init 1>/dev/null 2>&1
then
    eval "$(pyenv virtualenv-init -)"
fi


# docker
if command -v docker-machine 1>/dev/null 2>&1
then
    if [ "$(docker-machine status 2>/dev/null)" = "Running" ]
    then
        eval $(docker-machine env)
    fi
fi

# pipenv
if command -v pipenv 1>/dev/null 2>&1
then
    export PIPENV_VENV_IN_PROJECT=yes
fi


alias set_proxy="export ALL_PROXY=socks5://127.0.0.1:1086 && echo 'Proxy is on!'"
alias unset_proxy="unset ALL_PROXY && echo 'Proxy is off!'"

alias tmux="tmux -2 -f ~/.dotfiles/tmux.conf"

alias set_brew_no_auto_update="export HOMEBREW_NO_AUTO_UPDATE=1 && echo 'Auto update is off!'"
alias unset_brew_no_auto_update="unset HOMEBREW_NO_AUTO_UPDATE && echo 'Auto update is on!'"
