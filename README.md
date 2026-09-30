# Startup Files

Shell, editor, and desktop startup files for POSIX systems. The files in this
repository are templates for a user's home directory. They are maintained
against the live copies on a working host and installed on new hosts by the
`install-startup-files` script from the
[utility-scripts](https://github.com/mgmorey/utility-scripts) repository.

## Installation

Run `install-startup-files` interactively, as the target user, after the first
login on a freshly installed host. The script performs the following steps:

1. It clones this repository into `~/git/startup-files` unless a copy already
   exists under `~/Documents/git` or `~/git`.
2. It installs `.bash_profile`, `.bashrc`, `.editorconfig`, and `.profile`
   into the home directory. A file is installed only when it is missing or
   still identical to the distribution skeleton in `/etc/skel`, so customized
   files are never overwritten. Replaced files are kept with a `~` suffix.
3. It clones the [emacs-config](https://github.com/mgmorey/emacs-config)
   repository into `~/.config/emacs` when no `init.el` is present, links
   `~/.emacs.d` to that directory, and renames any legacy `~/.emacs` file to
   `~/.emacs.orig`.

Log out and back in to activate the new environment. The script can be run
again safely; it skips files that are already customized.

The remaining files are not installed by the script and should be copied by
hand where they apply.

## Startup Sequence

The Bourne-compatible startup files share a single login configuration:

- A bash login shell reads `.bash_profile`, which sources `.profile`.
- A POSIX `sh` login shell, and most graphical display managers, read
  `.profile` directly.
- `.profile` sets the login environment, sources `~/.profile.local` when it
  exists, and finally sources `.bashrc` when the shell is bash.
- An interactive non-login bash shell reads `.bashrc` only.

Settings that every session needs, such as `PATH` and exported variables,
belong in `.profile`. Settings that only interactive bash shells need, such as
aliases, the prompt, and completion, belong in `.bashrc`.

## Host-Specific Settings

`~/.profile.local` holds settings that apply to a single host or employer, such
as internal repository URLs, account user names, and additional `PATH`
entries. It is not part of this repository and is not installed by the script.
Create it by hand on each host that needs it. Because this repository is
public, host-specific values must never be committed to the templates.

## Helper Scripts

`.profile` calls the following scripts from `~/bin` when they are present.
They are provided by the utility-scripts repository:

- `get-nameserver` determines the Windows host address under WSL.
- `set-oss-parameters` adds optional software trees under `/opt` to the search
  paths.
- `set-parameters` sets general environment parameters.

## Contents

| File | Description |
|---|---|
| `.bash_logout` | Clears the console when a bash login shell exits. |
| `.bash_profile` | Bash login entry point; sources `.profile`. |
| `.bashrc` | Interactive bash settings: history, prompt, colors, aliases, completion, `nvm`, and `ssh-agent` helper functions. |
| `.config/fish/config.fish` | Fish shell configuration. |
| `docker-compose.yaml` | Database container definitions for local development; all services are disabled by default. |
| `.editorconfig` | Default editor settings for files under the home directory. |
| `etc/httpd.conf.patch` | Apache HTTP Server configuration patch for local PHP development on macOS. |
| `.gitattributes` | Git line-ending normalization for this repository. |
| `.gitignore` | Git exclusions for this repository, including environment files that may contain credentials. |
| `.login_conf` | FreeBSD login class settings for character set and locale. |
| `LICENSE` | GNU General Public License, version 3. |
| `.profile` | Login environment shared by all Bourne-compatible shells. |
| `README.md` | This document. |
| `.screenrc` | GNU Screen settings, including an escape key that does not conflict with Emacs. |
| `.shrc` | FreeBSD `sh` interactive settings. |
| `.Xresources` | X11 font and terminal settings for XTerm. |

## Interactive Helper Functions

`.bashrc` defines the following functions for managing a character-mode
`ssh-agent`:

- `clean_up_ssh_agent` stops an agent started by the current shell and removes
  the saved agent environment.
- `get_ssh_agent` reports a running agent or starts a new one.
- `is_valid_ssh_agent` tests whether the current agent socket is reachable.
- `start_ssh_agent` starts an agent, saves its environment to
  `~/.ssh/agent.env`, and stops it when the shell exits.

`.profile` defines `load_ssh_agent`, which reuses a saved agent environment at
login and discards it when the agent is no longer running. Desktop sessions
that already provide `SSH_AUTH_SOCK` are left unchanged.

## License

This project is licensed under the GNU General Public License, version 3. See
`LICENSE` for details.
