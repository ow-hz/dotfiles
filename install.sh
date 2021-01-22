#! /bin/bash


set -e
#set -x


# Common packages for Ubuntu including WSL, Archlinux and macOS
declare common_packages=()

# Packages of Archlinux
declare pacman_packages=()

# AUR packages of Archlinux
declare aur_packages=()

# Packages for macOS
declare brew_packages=()

# The Python modules which will be installed in system site packages folder
declare global_base_python_modules=(PyYAML)

# The Python modules which will be installed in user site packages folder
declare user_python_modules=()

declare os_name
declare os_ver

declare -r SLEEP_INTERVAL=0.2
declare -r MAX_RETRY_COUNT=2

# Vim to download
declare -r VIM_VERSION="v8.2.2129"
declare -r VIM_PKG_FORMAT="tar.gz"
declare -r VIM_PKG_NAME="${VIM_VERSION}.${VIM_PKG_FORMAT}"
declare -r VIM_DOWNLOAD_URL="https://codeload.github.com/vim/vim/$VIM_PKG_FORMAT/$VIM_VERSION"

# Default Python version
declare MY_DEFAULT_PYTHON="3.8.6"
declare PY3_PREFIX='pyenv prefix $MY_DEFAULT_PYTHON'
declare PY3_CONFIG='$PY3_PREFIX/bin/python-config --configdir'

declare -r PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

declare -r SOURCE_CODE_FOLDER="/usr/local/src"
declare -r VIM_SOURCE_CODE_FOLDER="$SOURCE_CODE_FOLDER/vim"

# Declare folder
declare -r DOTFILE_FOLDER="$HOME/.dotfiles"
declare -r SCRIPTS_FOLDER="$DOTFILE_FOLDER/scripts"

declare PATH="$PYENV_ROOT/bin:$PATH"


declare -r SHADOWSOCKS_LIBEV_CONFIG_FILE="/etc/shadowsocks-libev/config.json"

declare -r SHADOWSOCKS_LIBEV_CLIENT_SERVICE_FILE="/etc/systemd/system/shadowsocks-libev@client.service"
declare -r KCPTUN_CLIENT_SERVICE_FILE="/etc/systemd/system/kcptun@client.service"


declare -A FILES_TO_LINK=(
    ['config']=''
    ['zprofile']=''
    ['pam_environment']=''
)


function under_wsl() {
    grep -qEi '(Microsoft|WSL)' /proc/version &> /dev/null
    return $?
}


function link_brew_python3() {
    if command -v brew 1>/dev/null 2>&1; then
        local p=$(brew --cellar python)
        if [ -e $p ]; then
            for i in $(ls $p); do
                ln -s $p/$i/ $PYENV_ROOT/versions/$i-brew
                if [ $? -eq 0 ]; then
                    echo "$i linked to pyenv!"
                fi
            done
        fi
    else
        echo "Homebrew is not installed!"
    fi
}


function setup_environment() {
    # set AUR and install AUR package management tool
    if [[ $os_name == "Arch Linux" ]]; then
        if [[ "$(cat /etc/pacman.conf | grep '\[archlinuxcn\]')" == "" ]]; then
            sudo sed -i -e '$a \\n[archlinuxcn]' \
                -e '$a SigLevel = Optional TrustedOnly' \
                -e '$a Server = http://mirrors.163.com/archlinux-cn/$arch' /etc/pacman.conf
            pacman -Syy --noconfirm
            pacman -S archlinuxcn-keyring --noconfirm
            pacman -S yay --noconfirm
        fi
    fi
}


function setup_services() {
    # setup shoadowsocks service
    if [[ ! -e $SHADOWSOCKS_LIBEV_CONFIG_FILE ]]; then
        dir=$(echo $SHADOWSOCKS_LIBEV_CONFIG_FILE | rev | cut -d '/' -f 2- | rev)
        mkdir -p $dir

        echo "Creating $SHADOWSOCKS_LIBEV_CONFIG_FILE..."

        cat > $SHADOWSOCKS_LIBEV_CONFIG_FILE <<-EOF
{
  "server": "127.0.0.1",
  "server_port": "1081",
  "local_server": "127.0.0.1",
  "local_port": 1080,
  "password": "***",
  "method": "",
  "reuse_port": true,
  "fast_open": true
}
EOF
        echo "Done!"
    fi

    if [[ ! -e /etc/systemd/system/shadowsocks-libev@client.service ]]; then
        echo "Start shadowsocks-libev@client service..."

        cat > /etc/systemd/system/shadowsocks-libev@client.service <<-EOF
[Unit]
Description=shadowsocks-libev client
After=network.target

[Service]
ExecStart=/usr/bin/ss-local -c $SHADOWSOCKS_LIBEV_CONFIG_FILE
Restart=always

[Install]
WantedBy=multi-user.target
EOF

        systemctl daemon-reload
        systemctl enable shadowsocks-libev@client
        systemctl start shadowsocks-libev@client

        echo "Done!"
    fi

    # setup kcuptu service
    if [[ ! -e /etc/systemd/system/kcptun@client.service  ]]; then
        echo "Start kcptun@client service..."

        cat > /etc/systemd/system/kcptun@client.service <<-EOF
[Unit]
Description=kcptun client
After=shadowsocks-libev@client.target

[Service]
ExecStart=/usr/bin/kcptun-client -r 0.0.0.0:39901 -l 127.0.0.1:1081 --mode fast
Restart=always

[Install]
WantedBy=multi-user.target
EOF

        systemctl daemon-reload
        systemctl enable kcptun@client
        systemctl start kcptun@client

        echo "Done!"
    fi
#[General]
#EnableNetworkConfiguration=true

#[Network]
#NameResolvingService=systemd
}


function setup_color() {
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

function warning() {
    echo ${YELLOW}"[Warning]: $*"${RESET} >&2
}


function error() {
    echo ${RED}"[Error]: $*"${RESET} >&2
}


function info() {
    if [ $# -eq 2 ]; then
        if [ $1 = "-l" ]; then
            echo ${GREEN}"[INFO] $*"${RESET} >&2
        fi
    else
        echo ${GREEN}"$*"${RESET} >&2
    fi
}


function show_found() {
    info "✔ "$*
}


function show_not_found() {
    warning "X"$*
}



function command_exists() {
    command -v "$@" >/dev/null 2>&1
}


if [ -f /etc/os-release ]; then
    . /etc/os-release
    os_name=$NAME
    os_ver=$VERSION_ID

elif command_exists lsb_release; then
    os_name=$(lsb_release -si)
    os_ver=$(lsb_release -sr)

elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    os_name=$DISTRIB_ID
    os_ver=$DISTRIB_RELEASE

#elif command_exists hostnamectl; then
else
    error "can not identify your operation system"
fi


function assert_run_as_root() {
    if [ ! $(id -u) -eq 0 ]; then
        error "None root user. Please run as root. "
        exit 1
    fi
}


function install_package() {
    case $os_name in
        "Arch Linux")
            sudo pacman -S $* --noconfirm
            ;;
        "Ubuntu")
            sudo apt install $* --yes
            ;;
        "Darwin")
            brew install $*
            ;;
        *)
            error "The system you use is not supported."
            exit 1
            ;;
    esac
}


function uninstall_package() {
    if [[ $os_name == "Arch Linux" ]]; then
        pacman -Rsddn $* --noconfirm

    elif [[ $os_name == "Ubuntu" ]]; then
        apt remove $* --yes

    elif [[ $os_name == "Darwin" ]]; then
        brew uninstall $*
    else
        error "The system you use is not supported."
        exit 1
    fi
}


function exist_package() {
    if [[ $os_name == "Arch Linux" ]]; then
        pacman -Rsddn $* --noconfirm

    elif [[ $os_name == "Ubuntu" ]]; then
        apt remove $* --yes

    elif [[ $os_name == "Darwin" ]]; then
        brew uninstall $*
    fi
}


function check_pyenv() {
    command_exists pyenv && {
        show_found "pyenv"
        eval "$(pyenv init -)"

    } || {
        warning "pyenv is not found"
        return 1
    }

}


function install_pyenv() {
    info "Installing pyenv"
    if [[ $os_name == "Arch Linux" || $os_name == "Darwin" ]]; then
        install_package pyenv
    else
        if [[ ! -e ~/.pyenv ]] ;then
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        else
            warning "found pyenv folder"
            echo "change folder to pyenv"
            pushd ~/.pyenv &> /dev/null
            echo "updating pyenv..."
            git pull > /dev/null
            popd &> /dev/null
            info "done"
        fi
    fi
}


function install_pyenv_python() {
    local selection
    local count=0
    local flag_install=false

    if ! command_exists gcc; then
        if [[ $os_name == "Arch Linux" ]]; then
            install_package base-devel
        elif [[ $os_name == "Ubuntu" ]]; then
            install_package build-essential libssl-dev zlib1g-dev libbz2-dev \
                libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
                xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
        else
            error "You should install gcc in your system firstly"
        fi
    fi

    while true; do
        read -p ":: The defualt Python is ${RED}$MY_DEFAULT_PYTHON${RESET}, install or not [Y/C/n]: " selection
        #read "selection?:: The defualt Python is ${RED}$MY_DEFAULT_PYTHON${RESET}, install or not [Y/C/n]: "

        if [ $selection = 'n' ]; then
            error "Python compiled through pyenv is not installed"
            exit 1

        elif [[ $selection == 'Y' || $selection == 'C' ]]; then
            flag_install=true
            break

        else
            if [[ $count -lt $MAX_RETRY_COUNT ]]; then
                error "Not a valid choice, please try again"
                sleep $SLEEP_INTERVAL
            else
                error "Python compiled through pyenv is not installed"
                exit 1
            fi
        fi
        show_found "pyenv python $MY_DEFAULT_PYTHON"

        ((count=$count+1))
    done

    if [[ $selection == "C" ]]; then
        while true; do
            read -p ": The version to install: " MY_DEFAULT_PYTHON

            if [[ $(pyenv install --list | grep "^  $MY_DEFAULT_PYTHON$" 2>/dev/null) == "" ]]; then
                sleep $SLEEP_INTERVAL
                error "$MY_DEFAULT_PYTHON is not valid, try again"
            else
                break
            fi
        done
    fi

    info "Installing Python $MY_DEFAULT_PYTHON"

    if [[ $os_name == "Darwin" ]]; then
        env PYTHON_CONFIGURE_OPTS=--enable-framework pyenv install -fk $MY_DEFAULT_PYTHON
    else
        env PYTHON_CONFIGURE_OPTS=--enable-shared pyenv install -fk $MY_DEFAULT_PYTHON
    fi

    info "The Python $MY_DEFAULT_PYTHON compiled through pyenv has been installed"
}


function check_pyenv_python() {
    local ver=$(pyenv versions 2>/dev/null | grep " $MY_DEFAULT_PYTHON" | sed -e 's/^\s*//g' -e 's/\s*$//g')
    if [[ $ver != "" ]]; then 
        return 0
    fi

    return 1
}


function get_global_base_python_modules() {
    local array=() newarray=()
    for item in $(pip freeze 2>/dev/null | cut -d= -f 1); do
        array=(${array[@]} $item)
    done

    for item in ${global_base_python_modules[@]}; do
        if [[ " ${array[@]} " =~ " $item " ]]; then
            show_found "[Python Module]: $item"
        else
            show_not_found "[Python Module]: $item"
            newarray=($item ${newarray[@]})
        fi
    done

    global_base_python_modules=$newarray
}


function install_python_module() {
    for item in $@; do
        info "Installing $item"
        pip install $item
    done
}


function link_files() {
    if [[ "$os_name" == "Arch Linux" ]]; then

        for k in ${!FILES_TO_LINK[@]}; do
            v=${DOTFILES_TO_LINK[$k]}

            local src=$DOTFILE_FOLDER/$k
            local des=~/.$k

            if [[ $v != "" ]]; then
                des=$v
            fi

            if [[ ! -e $des ]]; then
                echo "Link $src to $des"
                ln -s $src $des
            else
                info "$des is found"
            fi
        done
    fi
}


function setup_zsh() {
    if [[ "$(cat /etc/passwd | grep $(whoami) | cut -d : -f 7)" != "$(which zsh)" ]]; then
        if ! chsh -s $(which zsh); then
            error "failed to change the default shell"
        fi
    else
        info "Your shell is ZSH"
    fi
}


function install_vim() {
    if [[ "$(which vim)" != "/usr/local/bin/vim" ]]; then
        [[ ! -e $SOURCE_CODE_FOLDER ]] && {
            sudo mkdir -p $VIM_SOURCE_CODE_FOLDER
        }

        if [[ ! -e $VIM_SOURCE_CODE_FOLDER/$VIM_PKG_NAME ]]; then
            echo 
        fi

        
        echo "Vim not found!"
        info "Downloading vim $VIM_VERSION..."
        curl -sSL -o $VIM_PKG_NAME $VIM_DOWNLOAD_URL
    fi

    if [[ ! -e /usr/local/lib/libpython3.so ]]; then
        ln -s ~/.pyenv/versions/$MY_DEFAULT_PYTHON/lib/libpython3.so /usr/local/lib/libpython3.so
    fi

    if [[ ! -e $VIM_SOURCE_CODE_FOLDER ]]; then
        git clone https://github.com/vim/vim $VIM_SOURCE_CODE_FOLDER
    fi

    pushd $VIM_SOURCE_CODE_FOLDER/src &> /dev/null && {
        echo "change work folder to $VIM_SOURCE_CODE_FOLDER/src"
    }

    local newest=$(git tag | sort -r | head -n 1)

    make uninstall && make clean

    ./configure \
        --with-features=huge \
        --with-python3-config-dir=$PY3_CONFIG \
        --with-tlib=ncurses \
        --enable-multibyte \
        --enable-python3interp=dynamic \
        --enable-terminal \
        --enable-cscope \
        --enable-gui=no \
        --enable-perlinterp=yes \
        --prefix=/usr/local

    make && make install
    popd
}


function load_packages() {
    pushd $SCRIPTS_FOLDER &> /dev/null
    common_packages=($(python ./packages.py common))

    pacman_packages=($(python ./packages.py archlinux pacman))

    aur_packages=($(python ./packages.py archlinux aur))

    brew_packages=$(python ./packages.py macos)

    popd &> /dev/null
}


function install_packages() {
    if [[ $os_name == "Arch Linux" ]]; then
        local packages=($(echo "$common_packages $pacman_packages" | sed -e 's/^\s*//g' -e 's/\s*$//g'))

        for item in ${pacman_packages[@]}; do
            install_package $item
        done

        for item in ${aur_packages[@]}; do
            yay -S $item --noconfirm
        done
    elif [[ $os_name == "Ubuntu" ]]; then
        for item in ${common_packages[@]}; do
            install_package $item
        done
    fi
}


#function check_packages() {
#}


#function save_config_files() {
#}


# Main function of the install.sh script
function main() {
    setup_color

    setup_environment

    #assert_run_as_root

    if ! check_pyenv; then
        install_pyenv
    fi

    if ! check_pyenv_python; then
        install_pyenv_python
    fi

    if [[ $(pyenv global | grep "^$MY_DEFAULT_PYTHON$" 2>/dev/null) != "$MY_DEFAULT_PYTHON" ]]; then
        info "Change the global Python of pyenv to $MY_DEFAULT_PYTHON"
        pyenv global $MY_DEFAULT_PYTHON
    fi

    get_global_base_python_modules
    install_python_module $global_base_python_modules

    
    echo "Loading pakcages"
    load_packages

    #echo "Checking packages"
    #check_packages

    install_packages

    # if ! check_vim; then
    #     install_vim
    # fi


    # save_config_files

    if [ -e ~/.oh-my-zsh ]; then
        local selection
        read -p "oh-my-zsh is found, update it? [Y/n]: " selection

        case $selection in
            "Y")
                pushd ~/.oh-my-zsh &> /dev/null
                info "Upating oh-my-zsh..."
                git pull
                popd &> /dev/null
                ;;
            *)
                ;;
        esac

    else
        git clone --branch master https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh
    fi

    [ -e ~/.zshrc ] && {
        info "Found ~/.zshrc"
    } || {
        info "Link zshrc to ~/.zshrc"
        ln -s $DOTFILE_FOLDER/zshrc ~/.zshrc
    }

    [ -e ~/.vimrc ] && {
        info "Found ~/.vimrc"
    } || {
        info "Link vimrc to ~/.vimrc"
        ln -s $DOTFILE_FOLDER/vimrc ~/.vimrc
    }


    setup_zsh

    #setup_services

    link_files

    install_vim


}


main $@
