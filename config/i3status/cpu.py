#! /bin/env python


import psutil
print(psutil.cpu_percent(interval=1), end='')
