function human_duration
	set -l duration (math "sqrt($argv[1]^2)")
	set -l seconds (math "$duration / 1000")
	set -l minutes (math "$seconds / 60")
	set -l hours (math "$minutes / 60")
	set -l days (math "$hours / 24")
	if [ $days -gt 0 ]
		echo $days"d "
	end
	if [ $hours -gt 0 ]
		echo (math "$hours % 24")"h "
	end
	if [ $minutes -gt 0 -a $days -lt 1 ]
		echo (math "$minutes % 60")"m "
	end
	if [ $seconds -gt 0 -a $hours -lt 1 ]
		if [ $minutes -gt 0 ]
			echo (math "$seconds % 60")"s "
		else
			echo (math "$seconds % 60")"."(math "$duration % 1000 / 100")"s"
		end
	end
	if [ $seconds -lt 1 ]
		echo $duration"ms"
	end
end
