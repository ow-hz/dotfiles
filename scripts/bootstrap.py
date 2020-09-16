#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import ssl
import sys
import copy
import json
import time
import urllib
import signal
import socket
import itertools
import threading
import subprocess
import multiprocessing
from enum import Enum, auto
from pathlib import Path
from os.path import dirname
from enum import Enum, auto
from urllib.parse import urlparse
from functools import wraps, partial
from collections import Counter, OrderedDict, Callable
from urllib.request import urlopen, Request as urlrequest

from utils import Color


HOME_DIR = Path.home()
DOTFILES_DIR = Path(dirname(os.path.realpath(__file__)))

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


class DefaultOrderedDict(OrderedDict):

    def __init__(self, default_factory=None, *args, **kwargs):
        if default_factory is not None \
                and not isinstance(default_factory, Callable):
            raise TypeError('First argument must be callable.')
        super(DefaultOrderedDict, self).__init__(*args, **kwargs)
        self.default_factory = default_factory

    def __getitem__(self, key):
        try:
            return super(DefaultOrderedDict, self).__getitem__(key)
        except KeyError:
            return self.__missing__(key)

    def __missing__(self, key):
        if self.default_factory is None:
            raise KeyError(key)
        return self.setdefault(key, self.default_factory())

    def __reduce__(self):
        if self.default_factory is None:
            args = tuple()
        else:
            args = self.default_factory,
        return type(self), args, None, None, self.items()

    def copy(self):
        return self.__copy__()

    def __copy__(self):
        return type(self)(self.default_factory, self)

    def __deecopy__(self, memo):
        return type(self)(self.default_factory,
                        copy.deepcopy(self.items()))

    def __deepcopy__(self, memo):
        return 'OrderedDefaultDict(%s, %s)' % (self.default_factory,
                                               OrderedDict.__repr__(self))



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


class Task(threading.Thread):

    def __init__(self, name, shell=True, daemon=True, **env):
        super(Task, self).__init__(name=name, daemon=daemon)
        self.stdout = None
        self.stderr = None
        self.shell = shell
        self.env = env

    def run(self, *args, **kwargs):
        env = os.environ.copy()
        env.update(self.env)
        p = subprocess.Popen([],
                            shell=self.shell,
                            check=True,
                            env=env,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
        p.stdout, p.stderr = p.communicate()


class Cli:

    def __init__(self):
        self.instructions = []
        self.finished = []
        self.settings = {}

    def show_options(self):
        self.echo('Please select')
        for n, i in enumerate(self.instructions):
            self.echo(f'({n+1}) {i.__name__}')
        self.echo('(a) all')
        self.echo('(q) to quit')

    def loading_settings(self):
        with open(DOTFILES_DIR / 'settings.json', 'r') as f:
            self.settings = json.load(f)

    # def execute(self, seq):
    #     self.instructions[seq]()

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

    def task(self, func):
        self.instructions.append(func)

    def echo(self, msg, style=None):
        msg = msg if style is None else style(msg)
        print(msg)

    def multiple_processing(self, func, args, cpu_count=multiprocessing.cpu_count()):
        with multiprocessing.Pool(processes=cpu_count) as p:
            p.map(func, args)


class Instruction:

    def __init__(self):
        pass

    def __call__(self):
        pass


cli = Cli()

os.chdir(HOME_DIR)


def brew_install(item):
    env = os.environ.copy()
    env['HOMEBREW_NO_AUTO_UPDATE'] = '1'
    p = subprocess.run(['brew', 'install', item], check=True, env=env)


def cask_install(item):
    # env = os.environ.copy()
    # env['HOMEBREW_NO_AUTO_UPDATE'] = '1'
    # p = subprocess.run(['brew', 'cask', 'install', item], check=True, env=env)
    pass


def mas_install(item_dict):
    env = os.environ.copy()
    env['HOMEBREW_NO_AUTO_UPDATE'] = '1'
    p = subprocess.run(['mas', 'install', item_dict[1]], check=True, env=env)


@cli.task
def install_oh_my_zsh():
    if not os.path.exists('.oh-my-zsh'):
        url = 'https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh'
        data = fetch_data(url, to_str=False)
        try:
            p = subprocess.run(['sh', '-c'], shell=True, check=True, input=data)
        except subprocess.CalledProcessError as error:
            cli.echo(fr_color.red)


@cli.task
def install_brew_apps():
    apps = cli.settings['brew_apps_to_install']

    # deps_counter = Counter()
    # def parse_deps(app_list):
    #     for i in app_list:
    #         deps_counter.update([i])
    #         deps = subprocess.check_output(['brew', 'deps', i]).decode('utf-8').strip('\n')
    #         if deps:
    #             parse_deps(deps.split('\n'))

    # parse_deps(apps)

    # def filter_deps():
    #     deps = DefaultOrderedDict(list)
    #     for k, v in deps_counter.most_common():
    #         deps[str(v)].append(k)
    #     return deps

    # deps = filter_deps()

    # for i in deps:
    #     for item in deps[i]:
    #         cli.multiple_processing(brew_install, deps[i], 1)

    env = os.environ.copy()
    env['HOMEBREW_NO_AUTO_UPDATE'] = '1'

    try:
        p = subprocess.run(['brew', 'install'] + apps, check=True, env=env)
    except KeyboardInterrupt as e:
        p.send_signal(signal.SIGINT)
    except subprocess.CalledProcessError as error:
        cli.echo(fr_color.red)

    # repos = ['concordusapps/pyenv-implict', 'pyenv/pyenv-doctor']
    # for repo in repos:
    #     url = f'https://github.com/{repo}.git'


@cli.task
def install_brew_cask_apps():
    apps = cli.settings['brew_cask_apps_to_install']
    cli.multiple_processing(cask_install, apps, cpu_count=1)


@cli.task
def link_dot_files():
    files = ['vimrc', 'tmux.conf', 'zshrc']
    items = cli.settings['files_to_link']

    for i in files:
        src = DOTFILES_DIR / i
        des = HOME_DIR / f'.{i}'
        if not os.path.exists(des):
            os.symlink(src, des)


@cli.task
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


@cli.task
def install_apps_from_mac_app_store():
    apps = cli.settings['mas_apps_to_install']
    cli.multiple_processing(mas_install, apps.items(), cpu_count=1)


if __name__ == '__main__':

    cli.run()
