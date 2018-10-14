dotfiles=~/.dotfiles
ohmyzsh=$dotfiles'/oh-my-zsh'


if [ ! -e $dotfiles ]
then
    echo '.dotfiles folder dosen`t exist ...'
    git clone https://github.com/alanowen/dotfiles $dotfiles
fi


if [ ! -e $ohmyzsh ]
then
    echo 'oh-my-zsh dosen`t` exist..'
    git clone https://github.com/robbyrussell/oh-my-zsh $ohmyzsh
fi


if [ ! -e ~/.zshrc ]
then
    echo 'create sybomlic of zshrc'
    ln -s $dotfiles/zshrc ~/.zshrc
else
    echo 'sybomic of zshrc exists...'
    ln -si $dotfiles/zshrc ~/.zshrc
fi
