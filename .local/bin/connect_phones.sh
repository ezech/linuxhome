#bt_id="00:02:3C:61:37:1A"
source "gpg2 -q -d ~/.local/secrets/bt_devices_id.gpg |"
bt_id="$bt_id_creative_headphones"
bt_card="bluez_card.${bt_id//:/_}"
bluetoothctl disconnect $bt_id
bluetoothctl connect    $bt_id
pactl set-card-profile $bt_card a2dp_sink

