choice() {
    local choice=$1
    if [[ ${selections[choice]} ]]; then
        selections[choice]=
    else
        selections[choice]=+
    fi
}

PS3='Install applications: '
apps=(
    '1password (https://1password.com)'
    'Kaleidoscope (https://kaleidoscope.app)'
    'LaunchControl (https://soma-zone.com)'
    'Opal (https://opalcamera.com)'
    'Parallels Desktop (https://parallels.com)'
    'PixelSnap 2 (https://getpixelsnap.com)'
    'Rectangle (https://rectangleapp.com)'
    'Tower (https://git-tower.com/mac)'
    'Vivid (https://getvivid.app)'
    'Zed (https://zed.dev/download)'
    'All'
    'Exit'
)
links=(
    'https://1password.com/downloads/mac/'
    'https://kaleidoscope.app/download'
    'https://opalcamera.com/opal-composer/download'
    'https://parallels.com/products/desktop/'
    'https://getpixelsnap.comx'
    'https://rectangleapp.com'
    'https://soma-zone.com/LaunchControl/'
    'https://git-tower.com/mac'
    'https://getvivid.app'
    'https://zed.dev/download'
)

select app in "${apps[@]}"; do
    case $app in
    'All')
        i=0
        while [ $((i += 1)) -lt $((${#apps[@]} - 1)) ]; do
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

for selection in "${!selections[@]}"; do
    if [[ ${selections[selection]} ]]; then
        open "${links[${selection} - 1]}"
    fi
done
