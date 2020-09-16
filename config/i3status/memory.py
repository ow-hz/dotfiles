#! /bin/env python


import psutil


print(psutil.virtual_memory()[2], end='')
