git="
.DS_Store\n
\n
# caches\n
.cache\n
.eslintcache\n
.stylelintcache\n
.temp\n
\n
# coverage\n
.nyc_output\n
*.lcov\n
coverage\n
lib-cov\n
\n
# editors\n
.idea\n
.fleet\n
.vscode\n
\n
# environment\n
.env\n
.env.development.local\n
.env.local\n
.env.production.local\n
.env.test.local\n
\n
# typescript\n
*.tsbuildinfo\n
\n
# vercel\n
.next\n
.vercel\n
\n
# yarn / npm\n
.npm\n
.pnp.*\n
.yalc\n
.yarn-integrity\n
.yarn/build-state.yml\n
.yarn/cache\n
.yarn/install-state.gz\n
.yarn/unplugged\n
node_modules\n
npm-debug.log*\n
yarn-debug.log*\n
yarn-error.log*"

plist="
<?xml version="1.0" encoding="UTF-8"?>\n
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n
<plist version="1.0">\n
<dict>\n
        <key>Label</key>\n
        <string>is.edil.reset-launchpad</string>\n
        <key>ProgramArguments</key>\n
        <array>\n
                <string>/usr/local/bin/fdautil</string>\n
                <string>exec</string>\n
                <string>/bin/zsh</string>\n
                <string>$HOME/Documents/GitHub/dotfiles/scripts/reset-launchpad.sh</string>\n
        </array>\n
        <key>RunAtLoad</key>\n
        <true/>\n
        <key>LaunchOnlyOnce</key>\n
        <true/>\n
        <key>StandardErrorPath</key>\n
        <string>/tmp/is.edil.reset-launchpad.err</string>\n
        <key>StandardOutPath</key>\n
        <string>/tmp/is.edil.reset-launchpad.out</string>\n
</dict>\n
</plist>"

PS3='Configure git ignore: '
select answer in "Yes" "No"; do
    case $answer in
        'Yes')
            if [[ ! -e "$HOME/.config/git/ignore" ]]; then
                mkdir -p "$HOME/.config/git"
                touch "$HOME/.config/git/ignore"
            fi
            echo $git | sed 's/^ *//g' > "$HOME/.config/git/ignore"
            break;;
        'No') break;;
    esac
done

PS3='Configure launchpad reset: '
select answer in "Yes" "No"; do
    case $answer in
        'Yes')
            if [[ ! -e "$HOME/Library/LaunchAgents/is.edil.reset-launchpad.plist" ]]; then
                mkdir -p "$HOME/Library/LaunchAgents/"
                touch "$HOME/Library/LaunchAgents/is.edil.reset-launchpad.plist"
            fi
            if [[ -e "/usr/local/bin/fdautil" ]]; then
                sudo /usr/local/bin/fdautil set agent is.edil.reset-launchpad $HOME/Documents/GitHub/dotfiles/scripts/reset-launchpad.sh
            else
                echo "fdautil not found, once fdautil is installed run the following command:\n\n$ sudo /usr/local/bin/fdautil set agent is.edil.reset-launchpad $HOME/Documents/GitHub/dotfiles/scripts/reset-launchpad.sh\n\nor configure fdautil through LaunchControl"
            fi
            echo $plist | sed 's/^ *//g' > "$HOME/Library/LaunchAgents/is.edil.reset-launchpad.plist"
            break;;
        'No') break;;
    esac
done

PS3='Download MonoLisa: '
select answer in "Yes" "No"; do
    case $answer in
        'Yes') open "https://www.monolisa.dev/orders"; break;;
        'No') exit;;
    esac
done
