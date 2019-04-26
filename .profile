# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# prepend GNU binaries to PATH
if [ -d /usr/gnu/bin ] ; then
    PATH="/usr/gnu/bin${PATH:+:$PATH}"
fi

# prepend GNU coreutils binaries to PATH
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin${PATH:+:$PATH}"
fi

# # configure environment for Homebrew packages
# export MANPATH=${MANPATH:-$(manpath)}

for pkg in erlang gdbm gettext git libffi openssl pcre2 python3 readline sqlite3 xz zlib; do
    if [ -d /usr/local/opt/$pkg/include ]; then
	export CPPFLAGS="-I/usr/local/opt/$pkg/include${CPPFLAGS:+ $CPPFLAGS}"
    fi
    if [ -d /usr/local/opt/$pkg/lib ]; then
	export LDFLAGS="-L/usr/local/opt/$pkg/lib${LDFLAGS:+ $LDFLAGS}"
    fi
    if [ -d /usr/local/opt/$pkg/lib/$pkg/man ] ; then
	export MANPATH="/usr/local/opt/$pkg/lib/$pkg/man${MANPATH:+:$MANPATH}"
    fi
    if [ -d /usr/local/opt/$pkg/bin ]; then
	export PATH="/usr/local/opt/$pkg/bin${PATH:+:$PATH}"
    fi
    if [ -d /usr/local/opt/$pkg/pkgconfig ]; then
	export PKG_CONFIG_PATH="/usr/local/opt/$pkg/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    fi
done

# # set PATH so it includes /usr/local/bin if it exists
# if [ -d "/usr/local/bin" ] ; then
#     PATH="/usr/local/bin${PATH:+:$PATH}"
# fi

# set PATH so it includes user's private Python 3 bin if it exists
for version in 3.8 3.7 3.6; do
    if [ -d "$HOME/Library/Python/$version/bin" ] ; then
	export PATH="$HOME/Library/Python/$version/bin${PATH:+:$PATH}"
	break
    fi
done

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin${PATH:+:$PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin${PATH:+:$PATH}"
fi

# set INFOPATH so it includes user's private info if it exists
if [ -d "$HOME/info" ] ; then
    export INFOPATH="$HOME/info${INFOPATH:+:$INFOPATH}"
fi

# set MANPATH so it includes user's private man if it exists
if [ -d "$HOME/man" ] ; then
    export MANPATH="$HOME/man${MANPATH:+:$MANPATH}"
fi

# # enable pipenv completion
# if [ -n "$BASH_VERSION" ]; then
#     eval "$(pipenv --completion)"
# fi

# # enable pyenv w/ completion
# export PATH="$HOME/.pyenv/bin${PATH:+:$PATH}"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# # set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
# if [ -n "$DISPLAY" ]; then
#     eval "$(askpass)"
# fi

export EDITOR=emacs
export FLASK_ENV=development
