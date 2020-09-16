# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#-----------------------------------------------------
#
# Personal settings
#
#-----------------------------------------------------
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

alias cnpm="npm --registry=https://registry.npm.taobao.org \
	--cache=$HOME/.npm/.cache/cnpm \
	--disturl=https://npm.taobao.org/dist \
	--userconfig=$HOME/.cnpmrc"

alias sudo="sudo "


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
        export DOCKER_HOST=tcp://192.168.210.7:2375
    fi
fi
# sudo timedatectl set-ntp true
# sudo hwclock --utc

