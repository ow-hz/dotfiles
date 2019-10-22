#! /bin/bash


function has_command() {
    # [[ $(command -v "nvim") == "" ]] && return 1 || return 0
    command -v $* >/dev/null 2>&1
    return $?
}


function show() {
    echo -e "\033[32m$*\033[0m"
}


function show_error() {
    echo -e "\033[31m$*\033[0m"
}


function show_warning() {
    echo -e "\033[33m$*\033[0m"
}


if ! has_command brew
then
    show_error "Homebrew is not found on your mac!"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code
fi


if ! has_command python3
then
    show_warning "Python3 is not installed!"
    pyenv install 3.7.1
    pyenv install 3.8.0
    pyenv global 3.8.0
fi

python3 ~/.dotfiles/bootstrap.py
