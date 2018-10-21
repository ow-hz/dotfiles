export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx &

[[ -f ~/.dotfiles/Xresources ]] && xrdb -merge -I$HOME ~/.dotfiles/Xresources

killall -q polybar

exec i3 -c ~/.dotfiles/i3/config -V >> ~/i3log-$(date +'%F') 2>&1
