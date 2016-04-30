function fish_title

	set -l process $_
	set -l god ""
	set -l on_project ""
	set -l title ""

	if [ (whoami) = "root" -o $_ = "sudo" ]
		set god "⚡ "
	end

	if set -q FISH_TITLE
		set title $FISH_TITLE
	else
		if [ $_ = "fish" ]
			set title (prompt_pwd)
		else
			if test (git rev-parse --is-inside-work-tree ^/dev/null)
				set on_project " on "(basename (git rev-parse --show-toplevel))
			end

			if [ $process = "sudo" ]
				set process (echo $history[1] | sed -e 's/^ *//g' -e 's/^sudo *//g' -e 's/\(^[^ ]*\)\(.*\)/\1/g')
			end

			set title $process""$on_project
		end
	end

	echo "$god"(add_padding $title (math 12 - (echo $title | wc -c) ) )

end
