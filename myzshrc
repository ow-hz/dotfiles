#! /usr/bin/env zsh

if command -v brew > /dev/null 2>&1; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi


setup_common() {
	# pyenv
	if command -v pyenv > /dev/null 2>&1; then
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"

		export PIPENV_VENV_IN_PROJECT=yes
		export PYENV_ROOT=$HOME/.pyenv
		eval "$(pyenv virtualenv-init -)"
	fi
}


setup_mac() {
	# brew
	local _brew=/opt/homebrew/bin/brew
	[ -x "${_brew}" ] && eval "$(${_brew} shellenv)"

	# ruby
	[ -d "$(brew --prefix)/opt/ruby/bin" ] \
		&& export PATH="/opt/homebrew/opt/ruby/bin:$PATH" \
		&& export GEM_HOME=$HOME/.gem \
		&& export PATH=$GEM_HOME/bin:$PATH

	# nvm
	export NVM_DIR="$HOME/.nvm"
	[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
	[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

	# common
	setup_common
}


setup_linux() {
	# sway
	if [ "$(tty)" = "/dev/tty1" ]; then
		export _JAVA_AWT_WM_NONREPARENTING=1
		export MOZ_ENABLE_WAYLAND=1
		exec sway
	fi

	# common
	setup_common
}


fallback() {
	echo "Unsupport operating system"
}


case "$(uname -s)" in
	Linux*) setup_linux;;
	Darwin*) setup_mac;;
	*) fallback;;
esac


if [[ "$(umask)" == "000" ]]; then
    umask 022
fi

export LC_ALL=en_US.UTF-8

# ZSH_THEME="spaceship"



plugins=(git node yarn autojump)

[[ -d $HOME/.local/bin ]] && [[ "$PATH" != *"$HOME/.local/bin"* ]] && export PATH=$HOME/.local/bin:$PATH


#[[ -d /usr/local/man ]] && export MANPATH=/usr/local/man:$MANPATH


alias launchpad_reset="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
# alias dosbox="dosbox -conf ~/.dotfiles/dosbox.conf"

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
    /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /opt/homebrew/etc/profile.d/autojump.sh
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

