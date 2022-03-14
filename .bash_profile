# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

# if running bash
if [ -n "${BASH_VERSION-}" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

umask 0027

export LANG=${LANG-en_US.UTF-8}
export LC_ALL=${LC_ALL-en_US.UTF-8}

export CONFIRM_PACKAGE_INSTALL=true
export EDITOR=emacs
export FLASK_ENV=development

if [ -n "${WSL_DISTRO_NAME-}" ]; then
    export WSL_HOST=$($HOME/bin/get-nameserver /etc/resolv.conf)
fi

# # set parameters for optional software
# gnu_dirs=/opt/gnu/{emacs,gdb,gnutls,nettle}
# opt_dirs=/opt/{curl,giflib,git,openssl,p11-kit,python,sbcl}

# if [ -x "$HOME/bin/set-oss-parameters" ]; then
#     eval "$($HOME/bin/set-oss-parameters $gnu_dirs $opt_dirs)"
# fi

# set parameters for Homebrew
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

# set parameters
if [ -x "$HOME/bin/set-parameters" ]; then
    eval "$($HOME/bin/set-parameters)"
fi

# enable pyenv
if which pyenv >/dev/null 2>&1; then
    case $- in
        *i*)
            eval "$(pyenv init --path)"
            ;;
    esac
fi
