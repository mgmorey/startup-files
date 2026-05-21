# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# The default umask is set in /etc/profile; for setting the umask
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

# If running bash
if [ -n "${BASH_VERSION-}" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# # Set parameters for optional software
# gnu_dirs=/opt/gnu/{emacs,gdb,gnutls,nettle}
# opt_dirs=/opt/{curl,giflib,git,openssl,p11-kit,python,sbcl}

# if [ -x "$HOME/bin/set-oss-parameters" ]; then
#     eval "$($HOME/bin/set-oss-parameters $gnu_dirs $opt_dirs)"
# fi

# Set parameters for Homebrew
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

# Set parameters
if [ -x "$HOME/bin/set-parameters" ]; then
    eval "$($HOME/bin/set-parameters)"
fi

# Enable pipenv completion
if which pipenv >/dev/null 2>&1; then
    case $- in
        *i*)
            if [ -n "${BASH_VERSION-}" ]; then
                eval "$(pipenv --completion | tr -d '\r')"
            fi
            ;;
    esac
fi

# Enable pyenv
if which pyenv >/dev/null 2>&1; then
    case $- in
        *i*)
            eval "$(pyenv init --path)"
            ;;
    esac
fi

# Start ssh-agent if necessary
if [ -z "$SSH_AUTH_SOCK" ] || ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
    trap 'ssh-agent -k' EXIT
fi
