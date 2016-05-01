# Put it at the end of a long-running command, 
# like system update, downloads or compilations.
# 
# @example
# 
# apt-get update; and apt-get dist-upgrade; done

function done --description 'Notify with visual and audible alert when process ends.'
	notify-send "$_ is done"
	# xkbbell is more cross-platform compilant
	# (if you have Xorg, you probably have xkbbell),
	# but I was unable to change the dafault sound.
	# xkbbell
	pacmd play-file /usr/share/sounds/gnome/default/alerts/glass.ogg 1 >  /dev/null ^ /dev/null
end
