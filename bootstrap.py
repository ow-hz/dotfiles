#! /usr/bin/env python3
# -*- coding: utf-8 -*-


import os
import re
import ssl
import sys
import json
import time
import urllib
import signal
import socket
import itertools
import subprocess
from pathlib import Path
from enum import Enum, auto
from urllib.parse import urlparse
from functools import wraps, partial
from urllib.request import urlopen, Request as urlrequest


home_dir = Path.home()
dotfiles_dir = Path(os.path.dirname(os.path.realpath(__file__)))

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
    try:
        req = urlrequest(url)
        o = urlparse(url)
        if o.scheme == 'https':
            context = ssl._create_unverified_context()
            resp = urlopen(req, context=context)
        else:
            resp = urlopen(req, timeout=1)
        data = resp.read()
        return data.decode('utf-8') if to_str else data
    except urllib.error as e:
        raise Exception('There was an error when fetching data: %r' % e)
    except socket.timeout as e:
        raise Exception('There was an error when fetching data: %r' % e)


class Cli:

    def __init__(self):
        self.instructions = []
        self.finished = []

    def show_options(self):
        self.echo('Please select')
        for n, i in enumerate(self.instructions):
            self.echo(f'({n+1}) {i.__name__}')
        self.echo('(a) all')
        self.echo('(q) to quit')

    def loading_settings(self):
        with open(dotfiles_dir / 'settings.json', 'r') as f:
            json_obj = json.load(f)

    def execute(self, seq):
        self.instructions[seq]()

    def run(self):
        self.loading_settings()
        while True:
            self.show_options()
            n = input('>> ')
            if n == 'q':
                break
            elif n == 'a':
                for i in self.instructions:
                    i()
            else:
                seqs = map(str, range(1, len(self.instructions) + 1))
                if n in seqs:
                    self.instructions[int(n) - 1]()
                else:
                    self.echo('Invalid selection!', style=fr_color.red)

    def instr(self, func):
        self.instructions.append(func)

    def echo(self, msg, style=None):
        msg = msg if style is None else style(msg)
        print(msg)


cli = Cli()

os.chdir(home_dir)


@cli.instr
def install_oh_my_zsh():
    if not os.path.exists('.oh-my-zsh'):
        url = 'https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh'
        data = fetch_data(url, to_str=False)
        try:
            p = subprocess.run(['sh', '-c'], shell=True, check=True, input=data)
        except subprocess.CalledProcessError as error:
            cli.echo(fr_color.red)


@cli.instr
def install_brew_packages():

    packages = [
        "autojump", "pyenv", "pyenv-virtualenv",
        "proxychains-ng", "node", "tmux", "yarn",
        "gnu-sed", "cmake", "bochs",
        "mosh", "docker", "docker-machine",
        "zsh-syntax-highlighting", "neovim"
    ]

    try:
        # p = subprocess.run(['brew', 'install'] + packages, check=True)
        p = subprocess.Popen(['brew', 'install'] + packages)
        p.wait()
    except KeyboardInterrupt as e:
        p.send_signal(signal.SIGINT)
    except subprocess.CalledProcessError as error:
        cli.echo(fr_color.red)

    repos = ['concordusapps/pyenv-implict', 'pyenv/pyenv-doctor']
    for repo in repos:
        url = f'https://github.com/{repo}.git'


@cli.instr
def link_dot_files():
    files = ['vimrc', 'tmux.conf']

    for i in files:
        src = dotfiles_dir / i
        des = home_dir / f'.{i}'
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
