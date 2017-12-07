function mycommits --description 'Recursively search for git repos, aggregate all commits made by me since given date and sort them by commit date.'
	find . -name ".git" -type d -exec git -C '{}' log --all --no-merges --since="$argv[1]" --committer="stefan" --pretty=format:"%ci, "(basename '{}')", \"%s\"" \; -exec echo "" \; \
		| grep -v '^$' \
		| sort \
		| sed 's/\.\///g' \
		| sed 's/\/\.git//g' \
		| sed 's/\.git, //g' \
		| sed 's/ \([0-9]\{2\}[: ]\)\{3\}-\?[0-9]\{4\}//g'
end
