# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

export EDITOR=emacs
export FLASK_ENV=development

# export CPPFLAGS="$CPPFLAGS${CPPFLAGS:+ }-I/usr/local/opt/sqlite/include"
# export CPPFLAGS="$CPPFLAGS${CPPFLAGS:+ }-I/usr/local/opt/zlib/include"
# export LDFLAGS="$LDFLAGS${LDFLAGS:+ }-L/usr/local/opt/libffi/lib"
# export LDFLAGS="$LDFLAGS${LDFLAGS:+ }-L/usr/local/opt/sqlite/lib"
# export LDFLAGS="$LDFLAGS${LDFLAGS:+ }-L/usr/local/opt/zlib/lib"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH${PKG_CONFIG_PATH:+:}/usr/local/opt/libffi/lib/pkgconfig"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH${PKG_CONFIG_PATH:+:}/usr/local/opt/sqlite/lib/pkgconfig"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH${PKG_CONFIG_PATH:+:}/usr/local/opt/zlib/lib/pkgconfig"

# # This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# # exists.
# #
# # if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# # set PATH so it includes /usr/gnu/bin if it exists
# if [ -d "/usr/gnu/bin" ] ; then
#     PATH="/usr/gnu/bin:$PATH"
# fi

# # set PATH so it includes /usr/local/bin if it exists
# if [ -d "/usr/local/bin" ] ; then
#     PATH="/usr/local/bin:$PATH"
# fi

# enable Python Package Manager
PATH="$HOME/.local/bin:$PATH"

# # enable Python Version Management
# PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

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

# # enable pipenv completion
# if [ -n "$BASH_VERSION" ]; then
#     eval "$(pipenv --completion)"
# fi

# # set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
# if [ -n "$DISPLAY" ]; then
#     eval "$(askpass)"
# fi
