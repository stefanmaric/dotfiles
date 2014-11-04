function human_duration

	set -l duration 0

	if [ (count $argv) -gt 0 ]
		set duration (math "sqrt($argv[1] ^ 2)")
	end

	set -l seconds (math "$duration / 1000")
	set -l minutes (math "$seconds / 60")
	set -l hours (math "$minutes / 60")
	set -l days (math "$hours / 24")
	set -l weeks (math "$days / 7")
	set -l months (math "$weeks / 4")
	set -l years (math "$weeks / 52")

	if [ $years -gt 0 ]
		echo $years"y"
	end

	if [ $months -gt 0 ]
		echo (math "$months % 12")"M"
	end

	if [ $weeks -gt 0 -a $years -lt 1 ]
		echo (math "$weeks % 4")"w"
	end

	if [ $days -gt 0 -a $months -lt 1 ]
		echo (math "$days % 7")"d"
	end

	if [ $hours -gt 0 -a $weeks -lt 1 ]
		echo (math "$hours % 24")"h"
	end

	if [ $minutes -gt 0 -a $days -lt 1 ]
		echo (math "$minutes % 60")"m"
	end

	if [ $seconds -gt 0 -a $hours -lt 1 ]
		if [ $minutes -gt 0 ]
			echo (math "$seconds % 60")"s"
		else
			echo (math "$seconds % 60")"."(math "$duration % 1000 / 100")"s"
		end
	end

	if [ $seconds -lt 1 ]
		echo $duration"ms"
	end

end
