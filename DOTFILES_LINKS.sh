#!/bin/env bash

declare -A DOTFILES_LINKS=(
  [bin/activate-terminal]="$HOME/bin/activate-terminal"
  [bin/cloneall]="$HOME/bin/cloneall"
  [bin/worklog]="$HOME/bin/worklog"
  [fish/config.fish]="$HOME/.config/fish/config.fish"
  [fish/fish_plugins]="$HOME/.config/fish/fish_plugins"
  [fish/functions/....fish]="$HOME/.config/fish/functions/....fish"
  [fish/functions/take.fish]="$HOME/.config/fish/functions/take.fish"
  [fish/functions/treediff.fish]="$HOME/.config/fish/functions/treediff.fish"
  [git/.gitconfig]="$HOME/.gitconfig"
  [stack/config.yaml]="$HOME/.stack/config.yaml"
  [prettier/.prettierrc.json]="$HOME/.prettierrc.json"
  [sublime/Default (Linux).sublime-keymap]="$HOME/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"
  [sublime/Package Control.sublime-settings]="$HOME/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"
  [sublime/Preferences.sublime-settings]="$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
  [vscode/settings.json]="$HOME/.config/Code/User/settings.json"
)

export DOTFILES_LINKS
