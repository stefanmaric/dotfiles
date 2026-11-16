function ccp --wraps=claude --description 'Run Claude Code with the personal config'
    env CLAUDE_CONFIG_DIR="$HOME/.claude-personal" claude --dangerously-skip-permissions $argv
end
