# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 022

# if [ "${USER_PROFILE_SOURCED-false}" = false ]; then

    # if running bash
    if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
	fi
    fi

    if [ -z "${INFOPATH-}" -a -d /usr/share/info ]; then
	export INFOPATH=/usr/local/share/info:/usr/share/info
    fi

    if [ -z "${MANPATH-}" -a -d /usr/share/man ]; then
	export MANPATH=/usr/local/share/man:/usr/share/man
    fi

    # set PATH so it includes /usr/lib/cups/bin if it exists
    if [ -d "/usr/lib/cups/bin" ] ; then
	export PATH="/usr/lib/cups/bin${PATH:+:$PATH}"
    fi

    # set paths so they include include pkgsrc directories (if they exist)
    for dir in $(ls -d /opt/local /opt/pkg /usr/pkg 2>/dev/null || true); do
	export PATH="$dir/bin:$dir/sbin${PATH:+:$PATH}"
	export INFOPATH="$dir/info${INFOPATH:+:$INFOPATH}"
	export MANPATH="$dir/man${MANPATH:+:$MANPATH}"
    done

    # set PATH so it includes /usr/local/sbin if it exists
    if [ -d /usr/local/sbin ] ; then
        export PATH="/usr/local/sbin${PATH:+:$PATH}"
    fi

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	export PATH="$HOME/bin${PATH:+:$PATH}"
    fi

    # set PATH so it includes user's private .local/bin
    export PATH="$HOME/.local/bin${PATH:+:$PATH}"

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
    #	if [ -n "$BASH_VERSION" ]; then
    #	    eval "$(pipenv --completion)"
    #	fi
    #	;;
    # esac

    # # enable pyenv w/ completion
    # export PATH="$HOME/.pyenv/bin${PATH:+:$PATH}"
    # case $- in
    #     *i*)
    #	eval "$(pyenv init -)"
    #	eval "$(pyenv virtualenv-init -)"
    #	;;
    # esac

    # # set GIT_ASKPASS, SSH_ASKPASS and SUDO_ASKPASS
    # if [ -n "$DISPLAY" ]; then
    #     eval "$(askpass)"
    # fi

    export EDITOR=emacs
    export FLASK_ENV=development

#     export USER_PROFILE_SOURCED=true
# fi
