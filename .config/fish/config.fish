# ~/.config/fish/config.fish

set -x EDITOR emacs
set -x FLASK_ENV development

function filter_fish
    tr '\n' ';'
end

eval (~/bin/set-parameters | filter_fish)

if which pipenv >/dev/null 2>&1
    eval (pipenv --completion | filter_fish)
end

if which pyenv >/dev/null 2>&1
    eval (pyenv init - | filter_fish)
    eval (pyenv virtualenv-init - | filter_fish)
end
