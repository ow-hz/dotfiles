dotfiles=~/.dotfiles
ohmyzsh=$dotfiles'/oh-my-zsh'
pyenv=$dotfiles'/pyenv'


install() {
    echo 'install packages...'
    for i in $*
    do
        sudo pacman -S $i
    done
}

# install core applications
install xorg xorg-xinit i3 dmenu xterm openssh tmux  zsh autojump
# install develop tools
install python3 python-pip python-virtualenv cmake
# install applications
install feh vim code fcitx fcitx-im fcitx-googlepinyin fcitx-configtool chromium 
# install fonts
install wqy-microhei wqy-zenhei adobe-source-code-pro-fonts ttf-font-awesome

# change login shell
if [ $0 != 'zsh' ]; then
    sudo chsh $(whoami) -s $(which zsh)
fi

# create dotfiles
if [ ! -e $dotfiles ]; then
    echo '.dotfiles folder dosen`t exist ...'
    git clone https://github.com/alanowen/dotfiles $dotfiles
fi

# create oh-my-zsh
if [ ! -e $ohmyzsh ]; then
    echo 'oh-my-zsh dosen`t exist..'
    git clone https://github.com/robbyrussell/oh-my-zsh $ohmyzsh
fi

# create symbolic
if [ ! -e ~/.zshrc ]; then
    echo 'create symbolic of .zshrc'
    ln -s $dotfiles/zshrc ~/.zshrc
else
    echo 'symboic of zshrc exists...'
    ln -si $dotfiles/zshrc ~/.zshrc
fi

# create symbolic
if [ ! -e ~/.vimrc]; then
    echo 'create symbolic of .vimrc'
    ln -s $dotfiles/vimrc ~/.vimrc
else
    echo 'symbolic of vimrc exists...'
    ln -si $dotfiles/vimrc ~/.vimrc
fi

# create symbolic
if [ ! -e ~/.xinitrc ]; then
    echo 'crate symbolic of .xinitrc'
    ln -s $dotfiles/xinitrc ~/.xinitrc
fi

# download vim bundle management tool
if [ ! -e ~/.vim/autoload/plug.vim ]; then
    echo 'download plug.vim'
    curl -Lo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c PlugInstall
fi

# download pyenv
if [ ! -e ~/.dotfiles/pyenv ];then
    git clone http://github.com/pyenv/pyenv.git $pyenv
fi

# download xterm color scheme
if [ ! -e $dotfiles/solarized_xresources ]; then
    git clone https://github.com/solarized/xresources $dotfiles/solarized_xresources
fi

echo 'Done!'
