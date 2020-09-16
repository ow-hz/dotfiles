#! /bin/env python


import psutil
print(psutil.disk_usage('/').percent, end='')

