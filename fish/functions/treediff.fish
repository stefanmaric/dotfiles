function treediff --description 'Pretty print the diff between to folder trees' --argument a b
	git diff --no-index -- (set -l f (mktemp); tree $a > $f; echo $f) (set -l f (mktemp); tree $b > $f; echo $f)
end
