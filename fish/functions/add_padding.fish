# add_padding string
# add_padding string padding_for_both_sides
# add_padding string padding_left padding_right

function add_padding --description "Add padding to a string"

  set -l string $argv[1]

  switch (count $argv) > /dev/null
    case 1

      set string " $string "

    case 2

	    for i in (seq $argv[2])
	      set string " $string "
	    end

	  case 3

	    for i in (seq $argv[2])
	      set string " $string"
	    end

	    for i in (seq $argv[3])
	      set string "$string "
	    end

  end

  echo "$string"

end
