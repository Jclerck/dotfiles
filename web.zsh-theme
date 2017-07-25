local resetColor="%{$reset_color%}"

local prefix=("" "" "%{$FG[012]%}" "" "%{$FG[012]%}" "" "%{$FG[202]%}" "%{$FG[202]%}" "%{$FG[226]%}" "%{$FG[006]%}" "%{$FG[165]%}" "" "" "%{$FG[012]%}" "" "%{$FG[010]%}")
local selection=${prefix[$(( $RANDOM % ${#prefix[@]} + 1 ))]}

local dir="%c"

local node=' $(npm config get node-version)'
local yarn=' $(yarn --version)'

local battery=$(pmset −g batt)

function stat() {
  local icons=''
  local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

  if [[ $git == true ]]; then
    local stashes=$(git stash list | grep -o '@' | tr -d '\n')
    local numberOfStashes=${#stashes}
    if [[ $numberOfStashes -gt 0 ]]; then
      icons="$icons  $numberOfStashes"
    fi

    local untracked=$(git status --porcelain | grep -o '??' | tr -d '\n')
    local numberOfUntracked=${#untracked}
    if [[ $numberOfUntracked -gt 0 ]]; then
      icons="$icons  $(($numberOfUntracked / 2))"
    fi

    local added=$(git status --porcelain | grep -o 'A' | tr -d '\n')
    local numberOfAdded=${#added}
    if [[ $numberOfAdded -gt 0 ]]; then
      icons="$icons  $numberOfAdded"
    fi

    local deleted=$(git status --porcelain | grep -o 'D' | tr -d '\n')
    local numberOfDeleted=${#deleted}
    if [[ $numberOfDeleted -gt 0 ]]; then
      icons="$icons  $numberOfDeleted"
    fi

    local modified=$(git status --porcelain | grep -o 'M' | tr -d '\n')
    local numberOfModified=${#modified}
    if [[ $numberOfModified -gt 0 ]]; then
      icons="$icons  $numberOfModified"
    fi

    local renamed=$(git status --porcelain | grep -o 'R' | tr -d '\n')
    local numberOfRenamed=${#renamed}
    if [[ $numberOfRenamed -gt 0 ]]; then
      icons="$icons  $numberOfRenamed"
    fi

    local conflicts=$(git status --porcelain | grep -o 'UU' | tr -d '\n')
    local numberOfConflicts=${#conflicts}
    if [[ $numberOfConflicts -gt 0 ]]; then
      icons="$icons  $(($numberOfConflicts / 2))"
    fi

    local ahead=$(git_commits_ahead)
    if [[  $ahead -gt 0 ]]; then
      icons="$icons  $ahead"
    fi

    local behind=$(git_commits_behind)
    if [[ -n $behind && $behind -gt 0 ]]; then
      icons="$icons  $behind"
    fi

    local remote=$(command git show-ref origin/$(git_current_branch))
    if [[ -z $remote ]]; then
      icons="$icons  "
    else
      if [[ $remote == "master" ]]; then
        icons="$icons  "
      else
        icons="$icons  "
      fi
    fi

    echo "at %{$FG[004]%}$(git_current_branch)$resetColor$resetColor$icons"
  fi
}

PROMPT='$selection $dir$resetColor$resetColor $(stat)'
RPROMPT="%{$FG[010]%}$node$resetColor$resetColor %{$FG[012]%}$yarn$resetColor$resetColor"
