export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx &

[[ -f ~/.dotfiles/Xresources ]] && xrdb -merge -I$HOME ~/.dotfiles/Xresources

exec i3 -V >> ~/i3log-$(date +'%F') 2>&1
