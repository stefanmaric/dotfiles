set -gx PATH $PATH $HOME/bin

set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin

set -gx fish_prompt_pwd_dir_length 3

set -gx GOPATH $HOME/go; set -gx GOROOT $HOME/.go; set -gx PATH $GOPATH/bin $PATH; # g-install: do NOT edit, see https://github.com/stefanmaric/g
