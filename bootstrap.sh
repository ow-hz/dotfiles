#! /bin/bash


function has_command() {
    # [[ $(command -v "nvim") == "" ]] && return 1 || return 0
    command -v $* >/dev/null 2>&1
    return $?
}


function show_msg() {
    echo -e "\033[32m$*\033[0m"
}


function show_error_msg() {
    echo -e "\033[31m$*\033[0m"
}


function show_warning_msg() {
    echo -e "\033[33m$*\033[0m"
}


if ! has_command brew
then
    show_error_msg "Homebrew is not found on your mac!"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


if ! has_command python3
then
    show_warning_msg "Python3 is not installed!"
    pyenv install 3.7.4
    pyenv global 3.7.4
fi

python3 ~/.dotfiles/bootstrap.py


# if [[ $(pip3 freeze | grep -E 'Click|click' | cut -d '=' -f 1) == '' ]]
# then
#     pip3 install click
# fi


# function install_pyenv_plugins() {
#     for name in $@
#     do
#         local plugin_name="$(echo $name | cut -d '/' -f 2)"
#         local plugin_folder="$PYENV_ROOT/plugins/$plugin_name"
#         local repo_url="git://github.com/$name.git"

#         if [ ! -d $plugin_folder ]; then
#             git clone $repo_url $plugin_folder
#             echo "[✓]$plugin_name"
#         fi
#     done
#     return 0
# }

