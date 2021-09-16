#! /usr/bin/env zsh


if [[ "$(umask)" == "000" ]]; then
    umask 022
fi

export LC_ALL=en_US.UTF-8

# ZSH_THEME="spaceship"

export PIPENV_VENV_IN_PROJECT=yes
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH


plugins=(git node yarn autojump)


eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


[[ -d $HOME/.local/bin ]] && [[ "$PATH" != *"$HOME/.local/bin"* ]] && export PATH=$HOME/.local/bin:$PATH


#[[ -d /usr/local/man ]] && export MANPATH=/usr/local/man:$MANPATH


alias launchpad_reset="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias dosbox="dosbox -conf ~/.dotfiles/dosbox.conf"

alias proxy_on="export ALL_PROXY=socks5://127.0.0.1:1080 && echo 'Proxy is on!'"
alias proxy_off="unset ALL_PROXY && echo 'Proxy is off!'"


alias brew_auto_update_on="unset HOMEBREW_NO_AUTO_UPDATE && echo 'Auto update is on!'"
alias brew_auto_update_off="export HOMEBREW_NO_AUTO_UPDATE=1 && echo 'Auto update is off!'"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

files=(
    /usr/local/etc/profile.d/autojump.sh
    /etc/profile.d/autojump.sh
    /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)

for i in $files; do
    if [ -e $i ]; then
        source $i
    fi
done


if command -v docker 1>/dev/null 2>&1; then
    if command -v docker-machine 1>/dev/null 2>&1; then
        if [ "$(docker-machine status 2>/dev/null)" = "Running" ]; then
            eval "$(docker-machine env)"
        fi
    else
        # export DOCKER_HOST=tcp://192.168.210.7:2375
    fi
fi
# sudo timedatectl set-ntp true
# sudo hwclock --utc

