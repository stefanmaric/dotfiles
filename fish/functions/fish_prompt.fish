function fish_prompt
    switch "$fish_key_bindings"
        case fish_hybrid_key_bindings fish_vi_key_bindings fish_helix_key_bindings
            set STARSHIP_KEYMAP "$fish_bind_mode"
        case '*'
            set STARSHIP_KEYMAP insert
    end

    set -l starship_status $status
    set -l starship_pipestatus $pipestatus
    set -l starship_duration "$CMD_DURATION$cmd_duration"

    __starship_set_job_count
    set -gx STARSHIP_HUMAN_DURATION (humantime $starship_duration)

    if test $starship_status -eq 0
        set -gx STARSHIP_STATUS_OK '•'
        set -e STARSHIP_STATUS_ERR
    else
        set -e STARSHIP_STATUS_OK
        set -gx STARSHIP_STATUS_ERR "$starship_status"
    end

    /opt/homebrew/bin/starship prompt --terminal-width="$COLUMNS" --status=$starship_status --pipestatus="$starship_pipestatus" --keymap=$STARSHIP_KEYMAP --cmd-duration=$starship_duration --jobs=$STARSHIP_JOBS
end
