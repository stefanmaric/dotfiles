function add_padding
	set -l padded $argv[1]
if test (count $argv) -lt 2
set padded "    $padded    "
else
for i in (seq $argv[2])
set padded " $padded "
end
end
echo "$padded"
end
