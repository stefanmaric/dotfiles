# Defined in - @ line 2
function crackzip --argument n file
	set -l chunkSize 100000

    set -l min (string repeat -n (math $n - 1) 9)
    set -l max (string repeat -n $n 9)
    set -l total (math $max - $min)
    set -l chunkNumber (math $total / $chunkSize)

    echo "$chunkNumber chunks of $chunkSize for a total of $total passwords"
    echo

    for chunkCount in (seq 1 $chunkNumber)
        set -l bottom (math "$min + ($chunkCount - 1) * $chunkSize")
        set -l top (math "$min + $chunkCount * $chunkSize")
        set -l count 0

        for pass in (shuf -i $bottom-$top)
            set count (math $count + 1)

            echo -ne "Chunk $chunkCount of $chunkNumber: "(math "$count * 100 / $chunkSize")"% - $pass \r"

            if 7z -so -aoa -p"$pass" e $file >/dev/null ^/dev/null
                echo
                echo "Password found:"
                echo "$pass"
                return 0
            end
        end
    end
    return 1
end
