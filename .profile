# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set profile parameters
if [ -x "$HOME/bin/set-parameters" ]; then
    eval "$($HOME/bin/set-parameters)"
fi

# enable pipenv completion
if [ -x $HOME/.local/bin/pipenv ]; then
    case $- in
        *i*)
            if [ -n "$BASH_VERSION" ]; then
                eval "$(pipenv --completion)"
            fi
            ;;
    esac
fi

# enable pyenv w/ completion
if [ -x $HOME/.pyenv/bin/pyenv ]; then
    case $- in
        *i*)
            eval "$(pyenv init -)"
            eval "$(pyenv virtualenv-init -)"
            ;;
    esac
fi

# # set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
# if [ -n "$DISPLAY" ]; then
#     eval "$(askpass)"
# fi

export EDITOR=emacs
export FLASK_ENV=development
