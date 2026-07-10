atuin init fish | source
fzf --fish | source
zoxide init fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path --path "$PNPM_HOME/bin"
# pnpm end

if test -x /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

set -gx GOPATH $HOME/go; set -gx GOROOT $HOME/.go; fish_add_path $GOPATH/bin # g-install: do NOT edit, see https://github.com/stefanmaric/g

fish_add_path --move --path "$HOME/.local/bin"

