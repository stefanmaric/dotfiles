set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.local/bin

atuin init fish | source
fzf --fish | source
zoxide init fish | source
starship init fish | source
