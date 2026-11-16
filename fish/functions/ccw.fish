function ccw --wraps=claude --description 'Run Claude Code with the work config'
    env CLAUDE_CONFIG_DIR="$HOME/.claude-work" claude --dangerously-skip-permissions $argv
end
