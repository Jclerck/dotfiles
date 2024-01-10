ln -sf "$(pwd)/.zshrc" ~
ln -sf "$(pwd)/.zprofile" ~

git clone git@github.com:Jmclerck/zsh-battery-status.git ~/.zsh/zsh-battery-status
git clone git@github.com:Jmclerck/zsh-git-status.git ~/.zsh/zsh-git-status
git clone git@github.com:mafredri/zsh-async.git ~/.zsh/zsh-async
git clone git@github.com:mfaerevaag/wd.git ~/.zsh/wd
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone git@github.com:zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone git@github.com:zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search

PS3='Installs applications & tools: '
scripts=(
    'Applications'
    'Tools'
    'All'
    'Quit'
)
select script in "${scripts[@]}"; do
    case $script in
    'Applications')
        ./applications.sh
        break
        ;;
    'Tools')
        ./tools.sh
        break
        ;;
    'All')
        ./applications.sh
        ./tools.sh
        break
        ;;
    'Quit')
        break
        ;;
    *)
        choice $REPLY
        ;;
    esac
done
