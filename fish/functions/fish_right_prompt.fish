function fish_right_prompt
	set_color --bold 999
	echo "$CMD_DURATION  "
	set_color normal
	set_color 999
	date "+%T"
	set_color normal
end
