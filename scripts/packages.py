#! /usr/bin/env python


import os
import sys
import functools

import yaml


PKG_FILE = os.path.abspath('./packages.yml')


if __name__ == '__main__':
    with open(PKG_FILE, 'r') as f:
        data = yaml.load(f.read(), Loader=yaml.Loader)
        for key in ['packages', *sys.argv[1:]]:
            data = data[key]
        data = ' '.join(data)
        print(data)
