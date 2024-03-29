if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

fish_add_path /usr/local/sbin
fish_add_path /Users/olivier/.cargo/bin
fish_add_path /usr/local/opt/llvm/bin

eval (opam env)

# Created by `userpath` on 2021-01-18 15:00:36
fish_add_path /Users/olivier/.local/bin

# function fish_vi_cursor; end

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

pyenv init - | source

