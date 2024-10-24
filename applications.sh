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
    'Chrome (https://google.co.uk/chrome)'
    'Docker (https://docker.com)'
    'Firefox (https://mozilla.org/en-US/firefox)'
    'Kaleidoscope (https://kaleidoscope.app)'
    'LaunchControl (https://soma-zone.com)'
    'Opal (https://opalcamera.com)'
    'Parallels Desktop (https://parallels.com)'
    'PixelSnap 2 (https://getpixelsnap.com)'
    'Polypane (https://polypane.app/download)'
    'Power Monitor (https://github.com/SAP/power-monitoring-tool-for-macos/releases)'
    'Rectangle (https://rectangleapp.com)'
    'Screenflow (https://telestream.net/screenflow/overview.htm)'
    'Tower (https://git-tower.com/mac)'
    'Vivid (https://getvivid.app)'
    'Zed (https://zed.dev/download)'
    'All'
    'Exit'
)
links=(
    'https://1password.com/downloads/mac/'
    'https://google.co.uk/chrome'
    'https://docker.com'
    'https://mozilla.org/en-US/firefox'
    'https://kaleidoscope.app/download'
    'https://soma-zone.com/LaunchControl/'
    'https://opalcamera.com/opal-composer/download'
    'https://parallels.com/products/desktop/welcome/'
    'https://getpixelsnap.com'
    'https://polypane.app/download/'
    'https://github.com/SAP/power-monitoring-tool-for-macos/releases'
    'https://rectangleapp.com'
    'https://telestream.net/screenflow/overview.htm'
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
