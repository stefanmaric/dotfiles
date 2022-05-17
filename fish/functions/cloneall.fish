# Requires Github's official CLI client: gh

function cloneall --description 'Script to clone all user or org repos from Github' --argument namespace
    for repo in (gh repo list $namespace --limit 1000 | awk '{print $1}')
        gh repo clone "$repo" (echo $repo | cut -d '/' -f 2)
    end
end
