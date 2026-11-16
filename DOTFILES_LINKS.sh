#!/bin/env bash

declare -A DOTFILES_LINKS=(
  [agents/AGENTS.md]="$HOME/.claude/CLAUDE.md $HOME/.claude-personal/CLAUDE.md $HOME/.config/opencode/AGENTS.md"
  [bin/git-gone-stats]="$HOME/.local/bin/git-gone-stats"
  [bin/git-env-only-branches]="$HOME/.local/bin/git-env-only-branches"
  [bin/git-purge]="$HOME/.local/bin/git-purge"
  [bin/git-publish]="$HOME/.local/bin/git-publish"
  [bin/worklog]="$HOME/.local/bin/worklog"
  [fish/conf.d/history-expansion.fish]="$HOME/.config/fish/conf.d/history-expansion.fish"
  [fish/conf.d/starship-context.fish]="$HOME/.config/fish/conf.d/starship-context.fish"
  [fish/conf.d/telemetry.fish]="$HOME/.config/fish/conf.d/telemetry.fish"
  [fish/config.fish]="$HOME/.config/fish/config.fish"
  [fish/functions/__history_previous_command.fish]="$HOME/.config/fish/functions/__history_previous_command.fish"
  [fish/functions/__history_previous_command_arguments.fish]="$HOME/.config/fish/functions/__history_previous_command_arguments.fish"
  [fish/functions/ccp.fish]="$HOME/.config/fish/functions/ccp.fish"
  [fish/functions/ccw.fish]="$HOME/.config/fish/functions/ccw.fish"
  [fish/functions/cloneall.fish]="$HOME/.config/fish/functions/cloneall.fish"
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
