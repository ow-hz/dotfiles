#! /usr/bin/env python3 
# -*- coding: utf-8 -*-


import os
import re
import sys
import urllib
import subprocess
from pathlib import Path
from enum import Enum, auto
from urllib.request import urlopen
from functools import wraps, partial


dirname = os.path.dirname
makedirs = partial(os.makedirs, exist_ok=True)


class Color(Enum):
    Black = 0
    Red = auto()
    Green = auto()
    Yellow = auto()
    BLue = auto()
    Purple = auto()
    Cyan = auto()
    White = auto()
    Reset = 9


class ColorMeta(type):
    def __new__(mls, clsname, bases, attrs):
        cls = type.__new__(mls, clsname, bases, attrs)
        
        for name, member in Color.__members__.items():
            k = name.lower()
            v = member.value + attrs['mask']
            v = f'\033[{v}m'
            setattr(cls, k, lambda msg, k=k, v=v: f'{v}{msg}\033[0m')
        return cls


class ForegroundColor(metaclass=ColorMeta):
    mask = 30


class BackgroundColor(metaclass=ColorMeta):
    mask = 40


fr_color = ForegroundColor
bg_color = BackgroundColor


def fetch_data(url, to_str=True):
    res = urlopen(url)
    data = res.read()
    return data.decode('utf-8') if to_str else data


class Cli:

    def __init__(self):
        self.instructions = []
        self.finished = []
    
    def run(self):
        while True:
            self.echo('Please select')
            for n, i in enumerate(self.instructions):
                self.echo(f'({n+1}) {i.__name__}')
            self.echo('(a) all')
            self.echo('(q) to quit')
            n = input('>')

            if n == 'q':
                break

            if n == 'a':
                for i in self.instructions:
                    i()


    def instr(self, func):
        self.instructions.append(func)


    def echo(self, msg, style=None):
        msg = msg if style is None else style(msg)
        print(msg)


cli = Cli()
home = Path.home()

os.chdir(home)


@cli.instr
def install_oh_my_zsh():
    url = 'https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh'
    data = fetch_data(url, to_str=False)
    try:
        subprocess.run(['sh', '-c'], shell=True, check=True, input=data)
    except subprocess.CalledProcessError as error:
        cli.echo(fr_color.red)


@cli.instr
def install_brew_packages():
    packages = [
        "autojump", "pyenv", "pyenv-virtualenv",
        "proxychains-ng", "node", "tmux", "yarn",
        "gnu-sed", "cmake", "pipenv",
        "mosh", "docker", "docker-machine",
        "zsh-syntax-highlighting", "neovim"
    ]


@cli.instr
def install_pyenv_pluginis():
    pyenv_dir = '.pyenv'
    makedirs(pyenv_dir)

    repos = ['concordusapps/pyenv-implict', 'pyenv/pyenv-doctor']
    for repo in repos:
        url = f'https://github.com/{repo}.git'


@cli.instr
def link_dot_files():
    files = ['vimrc', 'tmux.conf']
    dotfiles_dir = Path('.dotfiles')

    for i in files:
        src = dotfiles_dir / i
        des = f'.{i}'
        if not os.path.exists(des):
            os.symlink(src, des)


@cli.instr
def configure_vim():
    plug_path = Path('.vim/autoload/plug.vim')

    if not plug_path.exists():
        makedirs(dirname(plug_path))
        data = fetch_data('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
        with open(plug_path, 'w') as f:
            f.write(data)

    init_path = Path('.config/nvim/init.vim')

    if not init_path.exists():
        makedirs(dirname(init_path))
        with open(init_path, 'w') as f:
            f.write('set runtimepath^=~/.vim runtimepath+=~/.vim/after\n')
            f.write('let &packpath = &runtimepath\n')
            f.write('source ~/.vimrc\n')


@cli.instr
def configure_zsh():
    r = re.compile('source ~/.dotfiles/zshrc')
    with open('.zshrc', 'r+') as f:
        if not any(r.search(i) for i in f):
            f.write('\nsource ~/.dotfiles/zshrc')


if __name__ == '__main__':

    cli.run()
