# The network-manager-openvpn package has some issues.
# I can't import the .ovpn files that have the keys and certificates embeded.
# So I made this script to easily split them and put them into a given (or not given) folder
# so I can import them with Gnome's network manager without problem.
# 
# Import the resulting conf.ovpn file into the destination folder.
# 
# First argument should be the .ovpn config file.
# Second one is the destination folder, can be omited and filename of source will be used instead.
# Caution: this overwrites the given folder. I don't see the need to check it.
# 
# More info: http://askubuntu.com/questions/450493/openvpn-cant-import-configurations-on-new-14-04-installation

function splitOpenVpnFile --description "Split OpenVPN config files and save them in the given dir."
	set -l dirPath

	if [ (count $argv) -gt 1 ]
		set dirPath $argv[2]
	else
		set dirPath (echo $argv[1] | sed 's/\.[^\.]*$//g')
	end

	mkdir -p $dirPath

	# Extract keys and put them into the destination dir
	cat $argv[1]  | sed -n '/<ca>/,/<\/ca>/{/<ca>/b;/<\/ca>/b;p}' >  $dirPath/ca.crt
	cat $argv[1]  | sed -n '/<cert>/,/<\/cert>/{/<cert>/b;/<\/cert>/b;p}' >  $dirPath/cert.crt
	cat $argv[1]  | sed -n '/<key>/,/<\/key>/{/<key>/b;/<\/key>/b;p}' >  $dirPath/key.key

	# Copy the source config file...
	cp $argv[1] $dirPath/conf.ovpn

	# then remove the keys...
	sed -ni '/<cert>/{:a;N;/<\/cert>/!ba;N;s/.*\n//};p' $dirPath/conf.ovpn
	sed -ni '/<ca>/{:a;N;/<\/ca>/!ba;N;s/.*\n//};p' $dirPath/conf.ovpn
	sed -ni '/<key>/{:a;N;/<\/key>/!ba;N;s/.*\n//};p' $dirPath/conf.ovpn

	# add finally add a references to the previously generated key and crt files.
	echo "ca ca.crt" >>  $dirPath/conf.ovpn
	echo "cert cert.crt" >>  $dirPath/conf.ovpn
	echo "key key.key" >>  $dirPath/conf.ovpn
end
