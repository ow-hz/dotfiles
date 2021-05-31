#! /bin/bash
setup_mac() {
	# brew
	local _brew=/opt/homebrew/bin/brew
	[ -x "${_brew}" ] && eval "$(${_brew} shellenv)"

	# ruby
	[ -d "$(brew --prefix)/opt/ruby/bin" ] && export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

	# nvm
	export NVM_DIR="$HOME/.nvm"
	[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
	[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

setup_linux() {
	if [ "$(tty)" = "/dev/tty1" ]; then
		export _JAVA_AWT_WM_NONREPARENTING=1
		export MOZ_ENABLE_WAYLAND=1
		exec sway
	fi
}

fallback() {
	echo "Unsupport operating system"
}

case "$(uname -s)" in
	Linux*) setup_linux;;
	Darwin*) setup_mac;;
	*) fallback;;
esac
