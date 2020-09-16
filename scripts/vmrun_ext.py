#! /usr/bin/env python3

import os
import sys
import argparse
import threading
import subprocess
import multiprocessing
from pathlib import Path


vm_folder = Path.expanduser(Path('~/Virtual Machines.localized'))

parser = argparse.ArgumentParser('This is a ext script for vmrun command.')

parser.add_argument('-l', '--list-virtual-machines',
                        dest='show_list',
                        action='store_true',
                        help='show virtual machine installed')


subparser = parser.add_subparsers()
start_subparser = subparser.add_parser('start')
start_subparser.add_argument('name', action='store', metavar='vm name', help='start virtual machine by name')


def list_virtual_machines():
    if not vm_folder.exists():
        sys.exit('No vmware virtual machine folder found.')

    for i in os.listdir(vm_folder):
        if not i.startswith('.') and i.endswith('.vmwarevm'):
            print(i)


def start_virtual_machine(name):
    f = (vm_folder / name).glob('./*.vmx')
    try:
        f = next(f)
    except StopIteration:
        f = None
    if not f:
        sys.exit('No vmx file found.')

    # call vmrun to start the virtual machine
    # p = subprocess.Popen()
    cmd = ['vmrun', '-T', 'fusion', 'start', './Virtual Machines.localized/Ubuntu 64-bit Server 19.10.vmwarevm/Ubuntu 64-bit Server 19.10.vmx', 'nogui']
    # './Virtual Machines.localized/Ubuntu 64-bit Server 19.10.vmwarevm/Ubuntu 64-bit Server 19.10.vmx' nogui
    out = subprocess.check_output(['netstat', '-na', '-p', 'tcp'])
    print(out)
    print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')


def run():
    args = parser.parse_args()

    if args.show_list:
        list_virtual_machines()
    elif 'name' in args:
        start_virtual_machine(args.name)


if __name__ == '__main__':
    run()
