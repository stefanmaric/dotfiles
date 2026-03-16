function __stefanmaric_starship_set_context --argument-names exit_status duration_ms
    if test -z "$exit_status"
        set exit_status 0
    end

    if test -z "$duration_ms"
        set duration_ms 0
    end

    set -gx STARSHIP_HUMAN_DURATION (humantime $duration_ms)

    if test $exit_status -eq 0
        set -gx STARSHIP_STATUS_OK '•'
        set -e STARSHIP_STATUS_ERR
    else
        set -e STARSHIP_STATUS_OK
        set -gx STARSHIP_STATUS_ERR "$exit_status"
    end
end

function __stefanmaric_starship_postexec --on-event fish_postexec
    set -l duration_ms 0

    if set -q CMD_DURATION
        set duration_ms $CMD_DURATION
    else if set -q cmd_duration
        set duration_ms $cmd_duration
    end

    __stefanmaric_starship_set_context $status $duration_ms
end

__stefanmaric_starship_set_context 0 0
