# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 0027

export LANG=${LANG-en_US.UTF-8}
export LC_ALL=${LC_ALL-en_US.UTF-8}

export CONFIRM_PACKAGE_INSTALL=true
export EDITOR=emacs
export FLASK_ENV=development
export SSH_AGENT_ENV="$HOME/.ssh/agent.env"
export SSH_AGENT_OWNER="$HOME/.ssh/agent.owner"

cleanup_ssh_agent() {
    # Must be very defensive
    if [ -f "$SSH_AGENT_OWNER" ] &&
	   [ "$(cat "$SSH_AGENT_OWNER")" = "$$" ] &&
	   [ -n "$SSH_AGENT_PID" ] &&
	   kill -0 "$SSH_AGENT_PID" 2>/dev/null; then

        echo "Killing ssh-agent (PID $SSH_AGENT_PID)"
        ssh-agent -k >/dev/null
        rm -f "$SSH_AGENT_ENV" "$SSH_AGENT_OWNER"
    fi
}

load_ssh_agent() {
    [ -f "$SSH_AGENT_ENV" ] && source "$SSH_AGENT_ENV" >/dev/null
}

ssh_agent_is_valid() {
    [ -n "$SSH_AUTH_SOCK" ] &&
	[ -S "$SSH_AUTH_SOCK" ] &&
	kill -0 "$SSH_AGENT_PID" 2>/dev/null &&
	ssh-add -l >/dev/null 2>&1
}

start_ssh_agent() {
    eval "$(ssh-agent -s)"

    # Save environment
    mkdir -p "$(dirname "$SSH_AGENT_ENV")"
    cat > "$SSH_AGENT_ENV" <<EOF
export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
export SSH_AGENT_PID=$SSH_AGENT_PID
EOF

    # Record owner shell PID
    echo "$$" >"$SSH_AGENT_OWNER"

    # Register cleanup
    trap cleanup_ssh_agent EXIT
}

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

# Load existing SSH agent if possible
load_ssh_agent

# Start new SSH agent if needed
if ! ssh_agent_is_valid; then
    start_ssh_agent
fi
