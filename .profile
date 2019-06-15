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
    export PATH="/usr/gnu/bin${PATH:+:$PATH}"
fi

# set PATH so it includes /usr/local/sbin if it exists
if [ -d /usr/local/sbin ] ; then
    export PATH="/usr/local/sbin${PATH:+:$PATH}"
fi

# # set PATH so it includes /usr/local/bin if it exists
# if [ -d "/usr/local/bin" ] ; then
#     export PATH="/usr/local/bin${PATH:+:$PATH}"
# fi

# # configure environment for Homebrew packages
# export MANPATH=${MANPATH:-$(manpath)}

# prefix=/usr/local/opt

# for pkg in $($HOME/bin/brew-list-keg-only 2>/dev/null || true); do
#     if [ -d $prefix/$pkg ]; then
# 	if [ -d $prefix/$pkg/include ]; then
# 	    export CPPFLAGS="-I$prefix/$pkg/include${CPPFLAGS:+ $CPPFLAGS}"
# 	fi
# 	if [ -d $prefix/$pkg/lib ]; then
# 	    export LDFLAGS="-L$prefix/$pkg/lib${LDFLAGS:+ $LDFLAGS}"
# 	fi
# 	if [ -d $prefix/$pkg/lib/$pkg/man ] ; then
# 	    export MANPATH="$prefix/$pkg/lib/$pkg/man${MANPATH:+:$MANPATH}"
# 	fi
# 	if [ -d $prefix/$pkg/share/man ] ; then
# 	    export MANPATH="$prefix/$pkg/share/man${MANPATH:+:$MANPATH}"
# 	fi
# 	if [ -d $prefix/$pkg/bin ]; then
# 	    export PATH="$prefix/$pkg/bin${PATH:+:$PATH}"
# 	fi
# 	if [ -d $prefix/$pkg/lib/pkgconfig ]; then
# 	    export PKG_CONFIG_PATH="$prefix/$pkg/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
# 	fi
#     fi
# done

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
# case $- in
#     *i*)
# 	if [ -n "$BASH_VERSION" ]; then
# 	    eval "$(pipenv --completion)"
# 	fi
# 	;;
# esac

# # enable pyenv w/ completion
# export PATH="$HOME/.pyenv/bin${PATH:+:$PATH}"
# case $- in
#     *i*)
# 	eval "$(pyenv init -)"
# 	eval "$(pyenv virtualenv-init -)"
# 	;;
# esac

# # set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
# if [ -n "$DISPLAY" ]; then
#     eval "$(askpass)"
# fi

export EDITOR=emacs
export FLASK_ENV=development
