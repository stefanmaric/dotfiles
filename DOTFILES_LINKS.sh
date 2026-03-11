#!/bin/env bash

declare -A DOTFILES_LINKS=(
  [bin/worklog]="$HOME/bin/worklog"
  [fish/config.fish]="$HOME/.config/fish/config.fish"
  [fish/fish_plugins]="$HOME/.config/fish/fish_plugins"
  [fish/functions/....fish]="$HOME/.config/fish/functions/....fish"
  [fish/functions/cloneall.fish]="$HOME/.config/fish/functions/cloneall.fish"
  [fish/functions/take.fish]="$HOME/.config/fish/functions/take.fish"
  [fish/functions/treediff.fish]="$HOME/.config/fish/functions/treediff.fish"
  [git/.gitconfig]="$HOME/.gitconfig"
  [run-or-raise/shortcuts.conf]="$HOME/.config/run-or-raise/shortcuts.conf"
)

export DOTFILES_LINKS
