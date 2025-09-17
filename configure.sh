PS3='Download MonoLisa: '
select answer in "Yes" "No"; do
    case $answer in
        'Yes') open "https://www.monolisa.dev/orders"; break;;
        'No') exit;;
    esac
done
