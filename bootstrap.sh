dotfiles_dir="$HOME/.dotfiles"
ohmyzsh_dir="$dotfiles_dir/oh-my-zsh"

if ! command -v brew 1>/dev/null 2>&1; then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing oh-my-zsh..."
git clone https://github.com/robbyrussell/oh-my-zsh $ohmyzsh_dir

echo "Installing essential packages..."
brew install autojump vim pyenv pyenv-virtualenv \
	cmake python pipenv mosh docker docker-machine zsh-syntax-highlighting

if [ ! -f ~/.vimrc ]; then
  echo "Linking vimrc..."
  ln -s ~/.dotfiles/vimrc ~/.vimrc
fi

if [ ! -f ~/.zshrc ]; then
  echo "Linking zshrc..."
  ln -s ~/.dotfiles/zshrc ~/.zshrc
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  echo "Installing plug.vim..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Install plugins of vim..."


# # install core applications
# install xorg xorg-xinit i3 dmenu xterm openssh tmux  zsh autojump
# # install develop tools
# install python3 python-pip python-virtualenv cmake
# # install applications
# install feh xcompmgr vim code fcitx fcitx-im fcitx-googlepinyin fcitx-configtool chromium 
# # install fonts
# install wqy-microhei wqy-zenhei adobe-source-code-pro-fonts ttf-font-awesome gnome-alsamixer

# # change login shell
# if [ $0 != 'zsh' ]; then
#     sudo chsh $(whoami) -s $(which zsh)
# fi

# # create dotfiles
# if [ ! -e $dotfiles ]; then
#     echo '.dotfiles folder dosen`t exist ...'
#     git clone https://github.com/alanowen/dotfiles $dotfiles
# fi

# # create oh-my-zsh
# if [ ! -e $ohmyzsh ]; then
#     echo 'oh-my-zsh dosen`t exist..'
#     git clone https://github.com/robbyrussell/oh-my-zsh $ohmyzsh
# fi



# # # create symbolic
# # if [ ! -e ~/.xinitrc ]; then
# #     echo 'crate symbolic of .xinitrc'
# #     ln -s $dotfiles/xinitrc ~/.xinitrc
# # fi


# echo 'Done!'
