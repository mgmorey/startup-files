# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 0027

export LANG=${LANG-en_US.UTF-8}
export LC_ALL=${LC_ALL-en_US.UTF-8}

export CONFIRM_PACKAGE_INSTALL=true
export EDITOR=emacs
export FLASK_ENV=development
export SSH_AGENT_ENV="$HOME/.ssh/agent.env"

# If running bash
if [ -n "${BASH_VERSION-}" ]; then
    # Include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Set WSL_HOST for WSL Distros
if [ -n "${WSL_DISTRO_NAME-}" ]; then
    export WSL_HOST=$($HOME/bin/get-nameserver /etc/resolv.conf)
fi

# # set parameters for optional software
# gnu_dirs=/opt/gnu/{emacs,gdb,gnutls,nettle,texinfo}
# opt_dirs=/opt/{cppcheck,ctags,curl,git,openssl,p11-kit,sbcl}

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

# Enable pyenv
if which pyenv >/dev/null 2>&1; then
    case $- in
        *i*)
            eval "$(pyenv init --path)"
            ;;
    esac
fi

# In character-mode sessions, try to reuse a previously started agent.
# Skip in desktop sessions (e.g. GNOME) where SSH_AUTH_SOCK is already
# set by the session manager; loading agent.env there would override it.

if [ -z "$SSH_AUTH_SOCK" ]; then
    load_ssh_agent
fi
