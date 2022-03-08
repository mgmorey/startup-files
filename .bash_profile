# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 0027

export LANG=${LANG-en_US.UTF-8}
export LC_ALL=${LC_ALL-en_US.UTF-8}

export CONFIRM_PACKAGE_INSTALL=true
export EDITOR=emacs
export FLASK_ENV=development

if [ -n "${WSL_DISTRO_NAME-}" ]; then
    export WSL_HOST=$($HOME/bin/get-nameserver /etc/resolv.conf)
fi

# if running bash
if [ -n "${BASH_VERSION-}" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# # set parameters for optional software

# bits="$(uname -m | sed 's/x86_//')"
# gnudirs={gmp-6.2.1,gnutls-3.7.3,nettle-3.6}
# optdirs=gnu/$gnudirs

# for dir in $(find $(eval ls -d /opt/$optdirs | sort -r) -type d); do
#     case "$(basename "$dir" "$bits")" in
#         (include)
#             CPPFLAGS="-I$dir${CPPFLAGS+ $CPPFLAGS}"
#             ;;
#         (info)
#             INFOPATH="$dir${INFOPATH+:$INFOPATH}"
#             ;;
#         (lib)
#             LDLIBS="-L$dir${LDLIBS+ $LDLIBS}"
#             LD_LIBRARY_PATH="$dir${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}"
#             LD_RUN_PATH="$dir${LD_RUN_PATH+:$LD_RUN_PATH}"
#             ;;
#         (man)
#             MANPATH="$dir${MANPATH+:$MANPATH}"
#             ;;
#         (bin)
#             PATH="$dir${PATH+:$PATH}"
#             ;;
#         (pkgconfig)
#             PKG_CONFIG_PATH="$dir${PKG_CONFIG_PATH+:$PKG_CONFIG_PATH}"
#             ;;
#     esac
# done

# export CPPFLAGS INFOPATH LDLIBS LD_LIBRARY_PATH LD_RUN_PATH MANPATH PATH
# export PKG_CONFIG_PATH

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
