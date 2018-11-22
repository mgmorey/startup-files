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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set INFOPATH so it includes user's private info if it exists
if [ -d "$HOME/info" ] ; then
    INFOPATH="$HOME/info:$INFOPATH"
fi

# set MANPATH so it includes user's private man if it exists
if [ -d "$HOME/man" ] ; then
    MANPATH="$HOME/man:$MANPATH"
fi

# set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
# if [ -n "$DISPLAY" ]; then
#     eval `askpass`
# fi

# enable completion for pipenv
# if [ -n "$BASH_VERSION" ]; then
#     eval "$(pipenv --completion)"
# fi
