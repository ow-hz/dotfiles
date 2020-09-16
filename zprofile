#! /bin/bash


if [ "$(tty)" = "/dev/tty1" ]; then
    export _JAVA_AWT_WM_NONREPARENTING=1
    export MOZ_ENABLE_WAYLAND=1
    exec sway
fi
