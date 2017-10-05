local magenta="%{$FG[004]%}"
local lightblue="%{$FG[006]%}"
local red="%{$FG[009]%}"
local lightgreen="%{$FG[010]%}"
local darkblue="%{$FG[012]%}"
local darkgreen="%{$FG[028]%}"
local purple="%{$FG[165]%}"
local orange="%{$FG[202]%}"
local yellow="%{$FG[226]%}"
local resetColor="%{$reset_color%}"

local dir=" %c"
local prefix=("" "" "" "" "" "" "$orange" "$orange" "$orange" "$purple" "$yellow" "$darkblue" "$darkblue" "$darkblue" "$darkblue" "$darkgreen"  "$lightgreen" "$lightblue" "$lightblue" )
local selection=${prefix[$(( $RANDOM % ${#prefix[@]} + 1 ))]}

local node='$lightgreen  $(npm config get node-version)'
local yarn='$lightblue  $(yarn --version)'

function batt() {
  local source=$(pmset -g batt | grep -o 'AC Power')

  if [[ -z source ]]; then
    let remaining=$(pmset −g batt | grep -oE "([0-9]+\%).*" | cut -f1 -d ';')
    local indicators=("$red  " "$orange  " "$orange  " "$orange  " "$orange  " "$orange  " "$orange  " "$orange  " "$orange  " "$lightgreen  ");
    echo ${indicators[$(( floor($remaining / 10) ))]}$remaining%%
  fi
}

function stat() {
  local icons=''
  local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

  if [[ $git == true ]]; then
    local stashes=$(git stash list | grep -o '@' |  tr -d ' ' | tr -d '\n')
    local numberOfStashes=${#stashes}
    if [[ $numberOfStashes -gt 0 ]]; then
      icons="$icons  $numberOfStashes"
    fi

    local untracked=$(git status --porcelain | grep -o '^??\s' |  tr -d ' ' | tr -d '\n')
    local numberOfUntracked=${#untracked}
    if [[ $numberOfUntracked -gt 0 ]]; then
      icons="$icons  $(($numberOfUntracked / 2))"
    fi

    local added=$(git status --porcelain | grep -oE '^\sA\s|^A\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfAdded=${#added}
    if [[ $numberOfAdded -gt 0 ]]; then
      icons="$icons  $numberOfAdded"
    fi

    local deleted=$(git status --porcelain | grep -oE '^\sD\s|^D\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfDeleted=${#deleted}
    if [[ $numberOfDeleted -gt 0 ]]; then
      icons="$icons  $numberOfDeleted"
    fi

    local modified=$(git status --porcelain | grep -oE '^\sM\s|^M\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfModified=${#modified}
    if [[ $numberOfModified -gt 0 ]]; then
      icons="$icons  $numberOfModified"
    fi

    local renamed=$(git status --porcelain | grep -oE '^\sR\s|^R\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfRenamed=${#renamed}
    if [[ $numberOfRenamed -gt 0 ]]; then
      icons="$icons  $numberOfRenamed"
    fi

    local conflicts=$(git status --porcelain | grep -oE '^UU\s' |  tr -d ' ' | tr -d '\n')
    local numberOfConflicts=${#conflicts}
    if [[ $numberOfConflicts -gt 0 ]]; then
      icons="$icons  $(($numberOfConflicts / 2))"
    fi

    local staged=$(git status --porcelain |  grep -oE '^A\s{2}|^D\s{2}|^M\s{2}|^R\s{2}' | tr -d ' ' | tr -d '\n')
    local numberOfStaged=${#staged}
    if [[ $numberOfStaged -gt 0 ]]; then
      icons="$icons  $(($numberOfStaged))"
    fi

    local remote=$(git show-ref origin/$(git_current_branch) 2> /dev/null)
    if [[ -z $remote ]]; then
      icons="$icons  "
    else
      local ahead=$(git_commits_ahead)
      if [[ $ahead -gt 0 ]]; then
        icons="$icons  $ahead"
      fi

      local behind=$(git_commits_behind)
      if [[ $behind -gt 0 ]]; then
        icons="$icons  $behind"
      fi

      if [[ $(git_current_branch) == "master" ]]; then
        icons="$icons  "
      else
        icons="$icons  "
      fi
    fi

    echo "$resetColor at $magenta$(git_current_branch)$resetColor$icons"
  else
    echo "$resetColor  "
  fi
}

PROMPT='$selection$dir$(stat)$resetColor$resetColor'
RPROMPT="$node$yarn$(batt)$resetColor$resetColor"
