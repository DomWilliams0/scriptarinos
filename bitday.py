#!/usr/bin/env python2

import time
import sys
import os

WALLPAPERS = "~/Pictures/bitday"
hour = int(time.strftime("%H"))

choice = None
if hour < 3:
    choice = 11
elif hour < 5:
    choice = 12
elif hour < 7:
    choice = 1
elif hour < 9:
    choice = 2
elif hour < 11:
    choice = 3
elif hour < 12:
    choice = 4
elif hour < 15:
    choice = 5
elif hour < 17:
    choice = 6
elif hour < 19:
    choice = 7
elif hour < 20:
    choice = 8
elif hour < 22:
    choice = 9
elif choice < 24:
    choice = 10
else:
    raise StandardError("que")

os.system("feh --bg-fill %s/%02d*" % (WALLPAPERS, choice))
