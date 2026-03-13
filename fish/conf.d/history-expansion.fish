function __stefanmaric_history_expansion_bindings --on-variable fish_key_bindings
    bind --silent --erase --all !
    bind --silent --erase --all '$'

    switch "$fish_key_bindings"
        case '' fish_default_key_bindings
            bind --mode default ! __history_previous_command
            bind --mode default '$' __history_previous_command_arguments
        case fish_vi_key_bindings fish_hybrid_key_bindings fish_helix_key_bindings
            bind --mode insert ! __history_previous_command
            bind --mode insert '$' __history_previous_command_arguments
    end
end

__stefanmaric_history_expansion_bindings
