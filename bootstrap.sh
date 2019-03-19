dotfiles_dir="$HOME/.dotfiles"
ohmyzsh_dir="$dotfiles_dir/oh-my-zsh"

if ! command -v brew 1>/dev/null 2>&1; then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -d $ohmyzsh_dir ]; then
  echo "Installing oh-my-zsh..."
  git clone https://github.com/robbyrussell/oh-my-zsh $ohmyzsh_dir
fi

echo "Installing essential packages..."
brew install autojump vim pyenv pyenv-virtualenv proxychains-ng node tmux yarn \
	cmake python pipenv mosh docker docker-machine zsh-syntax-highlighting

if [ ! -f ~/.vimrc ]; then
  echo "Linking vimrc..."
  ln -s $dotfiles_dir/vimrc ~/.vimrc
fi

if [ ! -f ~/.zshrc ]; then
  echo "Linking zshrc..."
  ln -s $dotfiles_dir/zshrc ~/.zshrc
fi

if [ ! -f ~/.tmux.conf ]; then
  echo "Linking tmux.conf..."
  ln -s $dotfiles_dir/tmux.conf ~/.tmux.conf
fi

# if [ ! -f ~/.vim/autoload/plug.vim ]; then
#   echo "Installing plug.vim..."
#   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
# 	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

# echo "Install plugins of vim..."


echo 'All done!'
