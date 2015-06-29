function mycommits --description 'Recursively search for git repos, aggregate all commits made by me since given date and sort them by commit date.'
	find . -name ".git" -type d -exec git -C '{}' log --all --no-merges --since="$argv[1]" --committer="stefan" --pretty=format:"%cd {}: %s" --date=short \; -exec echo "" \; | sed 's/\.\///g' | sed 's/\/\.git//g' | grep -v '^$' | sort
end
