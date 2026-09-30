# ~/.profile: executed by the command interpreter for login shells.
# Bash login shells read ~/.bash_profile, which sources this file.
# Host-specific settings belong in ~/.profile.local (not version-controlled).

# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

umask 0027

# Configure locale
export LANG=${LANG-en_US.UTF-8}

# Configure development environment
export CONFIRM_PACKAGE_INSTALL=true
export EDITOR=emacs
export FLASK_DEBUG=1
export HISTTIMEFORMAT='%F %T '
export HTML_THEME=github.dark-green
export SSH_AGENT_ENV="$HOME/.ssh/agent.env"

# Debian and RHEL install the system CA bundle at different paths
for ca_bundle in /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt; do
    if [ -r "$ca_bundle" ]; then
        export NODE_EXTRA_CA_CERTS="$ca_bundle"
        break
    fi
done

unset ca_bundle

load_ssh_agent() {
    [ -f "$SSH_AGENT_ENV" ] || return 0
    . "$SSH_AGENT_ENV" >/dev/null

    # ssh-add exits with status 2 when it cannot reach the agent
    if [ ! -S "${SSH_AUTH_SOCK-}" ] || { ssh-add -l >/dev/null 2>&1; [ $? -eq 2 ]; }; then
        unset SSH_AUTH_SOCK SSH_AGENT_PID
        rm -f "$SSH_AGENT_ENV"
    fi
}

# Set WSL_HOST for WSL Distros
if [ -n "${WSL_DISTRO_NAME-}" ]; then
    WSL_HOST=$("$HOME/bin/get-nameserver" /etc/resolv.conf)
    export WSL_HOST
fi

# Set parameters
if [ -x "$HOME/bin/set-parameters" ]; then
    eval "$("$HOME/bin/set-parameters")"
fi

# Set GNU/optional software parameters
gnu_dirs="/opt/gnu/emacs /opt/gnu/gmp /opt/gnu/gnutls /opt/gnu/libidn \
/opt/gnu/libtasn1 /opt/gnu/libunistring /opt/gnu/nettle /opt/gnu/texinfo"
opt_dirs="/opt/ctags $gnu_dirs /opt/libpsl"

if [ -x "$HOME/bin/set-oss-parameters" ]; then
    eval "$("$HOME/bin/set-oss-parameters" $opt_dirs)"
fi

unset gnu_dirs opt_dirs

# Set Cargo parameters
if [ -r "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Set Homebrew parameters (appended to PATH so the system toolchain wins)
for brew_cmd in /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
    if [ -x "$brew_cmd" ]; then
        # The bash form of shellenv output is POSIX-compatible
        eval "$("$brew_cmd" shellenv bash | grep -Ev '^export (INFOPATH|PATH)=')"
        case ":${INFOPATH-}:" in
            (*":$HOMEBREW_PREFIX/share/info:"*) ;;
            (*) export INFOPATH="$HOMEBREW_PREFIX/share/info${INFOPATH:+:$INFOPATH}" ;;
        esac
        for dir in "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"; do
            case ":$PATH:" in
                (*":$dir:"*) ;;
                (*) PATH="$PATH:$dir" ;;
            esac
        done
        export PATH
        export HOMEBREW_NO_ANALYTICS=1
        break
    fi
done

unset brew_cmd dir

# Set user-specific parameters
for dir in "$HOME/bin" "$HOME/.local/bin"; do
    case ":$PATH:" in
        (*":$dir:"*) ;;
        (*) PATH="$dir:$PATH" ;;
    esac
done

export PATH
unset dir

# Set host-specific parameters
if [ -r "$HOME/.profile.local" ]; then
    . "$HOME/.profile.local"
fi

# In character-mode sessions, try to reuse a previously started agent.
# Skip in desktop sessions (e.g. GNOME) where SSH_AUTH_SOCK is already
# set by the session manager; loading agent.env there would override it.

if [ -z "${SSH_AUTH_SOCK-}" ]; then
    load_ssh_agent
fi

# Get the aliases and functions (if running bash)
if [ -n "${BASH_VERSION-}" ]; then
    # Include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
