set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.local/bin

source ~/.config/fish/functions/fish_prompt.fish

atuin init fish | source
fzf --fish | source
zoxide init fish | source
starship init fish | source
