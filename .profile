# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 0027

LANG=${LANG-en_US.UTF-8}
LC_ALL=${LC_ALL-en_US.UTF-8}
export LANG LC_ALL

CONFIRM_PACKAGE_INSTALL=true
EDITOR=emacs
FLASK_ENV=development
export CONFIRM_PACKAGE_INSTALL EDITOR FLASK_ENV

if [ -n "${WSL_DISTRO_NAME-}" ]; then
    WSL_HOST=$($HOME/bin/get-nameserver /etc/resolv.conf)
    export WSL_HOST
fi

# if running bash
if [ -n "${BASH_VERSION-}" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
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

# enable pipenv completion
if which pipenv >/dev/null 2>&1; then
    case $- in
        *i*)
            if [ -n "${BASH_VERSION-}" ]; then
                eval "$(pipenv --completion | tr -d '\r')"
            fi
            ;;
    esac
fi

# enable pyenv
if which pyenv >/dev/null 2>&1; then
    case $- in
        *i*)
            eval "$(pyenv init --path)"
            ;;
    esac
fi
