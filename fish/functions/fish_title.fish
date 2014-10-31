function fish_title
	if set --query FISH_TITLE
		echo $FISH_TITLE
	else
		set -l on_project ""
		if [ $_ = "fish" ]
			add_padding (prompt_pwd) (math 10-(prompt_pwd | wc -c))
		else
			if test (command git rev-parse --is-inside-work-tree ^/dev/null)
				set on_project "on "(basename (git rev-parse --show-toplevel))
			end
			add_padding (echo "$_ $on_project") (math 10-(echo "$_ $on_project" | wc -c))
		end
	end
end
