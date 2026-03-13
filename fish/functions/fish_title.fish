function fish_title
    set -l process $_
    set -l god ''
    set -l on_project ''
    set -l title ''

    if test (whoami) = root -o "$process" = sudo
        set god '( ⚡ )'
    end

    if set -q FISH_TITLE
        set title $FISH_TITLE
    else if test "$process" = fish
        set title (prompt_pwd)
    else
        if git_is_repo
            set on_project ' on '(basename (git_repository_root))
        end

        if test "$process" = sudo
            set process (echo $argv | sed -e 's/^ *//g' -e 's/^sudo *//g' -e 's/\(^[^ ]*\)\(.*\)/\1/g')
        end

        set title $process$on_project
    end

    echo "$god  $title"
end
