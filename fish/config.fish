atuin init fish | source
fzf --fish | source
zoxide init fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path --path "$PNPM_HOME/bin"
# pnpm end

fish_add_path --move --path "$HOME/.local/bin"

