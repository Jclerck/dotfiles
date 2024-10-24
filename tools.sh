choice() {
    local choice=$1
    if [[ ${selections[choice]} ]]; then
        selections[choice]=
    else
        selections[choice]=+
    fi
}

truncate -s 0 ./.path.zprofile
truncate -s 0 ./.completion.zprofile

PS3='Install tools: '
binaries=(
    ''
    '$DENO_PREFIX/bin'
    ''
    ''
    '$N_PREFIX/bin'
)
completions=(
    'eval "$(op completion zsh)"; compdef _op op'
    'eval "$(deno completions zsh)"; compdef _deno deno'
    'eval "$(gh completion -s zsh)"; compdef _gh gh'
    'eval "$(/opt/homebrew/bin/brew shellenv)"'
    ''
)
links=(
    'https://developer.1password.com/docs/cli/get-started/#step-1-install-1password-cli'
    'https://docs.deno.com/runtime/manual/getting_started/installation'
    'https://cli.github.com'
    'https://brew.sh'
    'https://github.com/mklement0/n-install'
)
paths=(
    ''
    'export DENO_PREFIX=$HOME/.deno'
    ''
    ''
    'export N_PREFIX=$HOME/.n'
)
tools=(
    '1password CLI (https://developer.1password.com)'
    'Deno (https://deno.land)'
    'Github CLI (https://cli.github.com)'
    'Homebrew (https://brew.sh)'
    'N (https://github.com/tj/n)'
    'All'
    'Exit'
)

select tool in "${tools[@]}"; do
    case $tool in
    'All')
        i=0
        while [ $((i += 1)) -lt $((${#tools[@]} - 1)) ]; do
            choice i
        done
        break
        ;;
    'Exit')
        break
        ;;
    *)
        choice $REPLY
        ;;
    esac
done

export='\nexport PATH='

for selection in "${!selections[@]}"; do
    if [[ ${selections[selection]} ]]; then
        open "${links[${selection} - 1]}"

        if [[ ! $(grep "${paths[${selection} - 1]}" ./.path.zprofile) ]]; then
            if [[ -n ${paths[${selection} - 1]} ]]; then
                echo "${paths[${selection} - 1]}" >> ./.path.zprofile
            fi
        fi

        if [[ -n ${binaries[${selection} - 1]} ]]; then
            export=$export${binaries[${selection} - 1]}':'
        fi

        if [[ ! $(grep "${completions[${selection} - 1]}" ./.completion.zprofile) ]]; then
            if [[ -n ${completions[${selection} - 1]} ]]; then
                echo "${completions[${selection} - 1]}" >> ./.completion.zprofile
            fi
        fi
    fi
done

echo ${export}'$PATH' >> ./.path.zprofile
