#!/bin/env bash

declare -A DOTFILES_LINKS=(
  [bin/worklog]="$HOME/bin/worklog"
  [fish/conf.d/history-expansion.fish]="$HOME/.config/fish/conf.d/history-expansion.fish"
  [fish/config.fish]="$HOME/.config/fish/config.fish"
  [fish/functions/__history_previous_command.fish]="$HOME/.config/fish/functions/__history_previous_command.fish"
  [fish/functions/__history_previous_command_arguments.fish]="$HOME/.config/fish/functions/__history_previous_command_arguments.fish"
  [fish/functions/cloneall.fish]="$HOME/.config/fish/functions/cloneall.fish"
  [fish/functions/fish_prompt.fish]="$HOME/.config/fish/functions/fish_prompt.fish"
  [fish/functions/fish_title.fish]="$HOME/.config/fish/functions/fish_title.fish"
  [fish/functions/git_is_repo.fish]="$HOME/.config/fish/functions/git_is_repo.fish"
  [fish/functions/git_repository_root.fish]="$HOME/.config/fish/functions/git_repository_root.fish"
  [fish/functions/humantime.fish]="$HOME/.config/fish/functions/humantime.fish"
  [fish/functions/take.fish]="$HOME/.config/fish/functions/take.fish"
  [fish/functions/treediff.fish]="$HOME/.config/fish/functions/treediff.fish"
  [ghostty/config.ghostty]="$HOME/.config/ghostty/config.ghostty"
  [git/.gitconfig]="$HOME/.gitconfig"
  [run-or-raise/shortcuts.conf]="$HOME/.config/run-or-raise/shortcuts.conf"
  [starship/starship.toml]="$HOME/.config/starship.toml"
)

export DOTFILES_LINKS
