# ~/.config/fish/config.fish
# -*- Mode: Shell-script -*-

set -x EDITOR emacs
set -x FLASK_ENV development

function newline_to_semicolon
    tr '\n' ';'
end

eval (~/bin/set-parameters | newline_to_semicolon)

if which pyenv >/dev/null 2>&1
    eval (pyenv init - | newline_to_semicolon)
    eval (pyenv virtualenv-init - | newline_to_semicolon)
end
