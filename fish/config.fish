set -gx PATH $PATH $HOME/bin

set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin

set -gx fish_prompt_pwd_dir_length 3

set -gx GOENV_ROOT $HOME/.goenv
set -gx PATH $GOENV_ROOT/bin $PATH
