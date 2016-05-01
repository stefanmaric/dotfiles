function take --description 'Creates a directory and takes you inside'
	mkdir -p $argv[1]
	cd $argv[1]
end
