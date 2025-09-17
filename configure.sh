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

PS3='Download MonoLisa: '
select answer in "Yes" "No"; do
    case $answer in
        'Yes') open "https://www.monolisa.dev/orders"; break;;
        'No') exit;;
    esac
done
