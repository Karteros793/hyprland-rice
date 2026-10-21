#!/usr/bin/env bash
# Wi-Fi меню (rofi + nmcli)
THEME="$HOME/.config/rofi/launcher.rasi"
nmcli radio wifi on >/dev/null 2>&1
nmcli device wifi rescan >/dev/null 2>&1

list=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | awk -F: '$1!="" && !seen[$1]++ {printf "%s  (%s%%) %s\n",$1,$2,($3==""?"open":"secured")}')
choice=$(printf 'Вимкнути Wi-Fi\nПерезапустити Wi-Fi\n%s\n' "$list" | rofi -dmenu -p wifi -theme "$THEME")
[[ -z "$choice" ]] && exit 0

case "$choice" in
  "Вимкнути Wi-Fi") nmcli radio wifi off; notify-send "Wi-Fi" "Вимкнено" 2>/dev/null; exit 0 ;;
  "Перезапустити Wi-Fi") nmcli radio wifi off; sleep 1; nmcli radio wifi on; exit 0 ;;
esac

ssid="${choice%%  (*}"
if nmcli -t -f NAME connection show | grep -qx "$ssid"; then
  nmcli connection up "$ssid"
elif [[ "$choice" == *open ]]; then
  nmcli device wifi connect "$ssid"
else
  pass=$(rofi -dmenu -password -p "пароль" -theme "$THEME" </dev/null)
  [[ -z "$pass" ]] && exit 0
  nmcli device wifi connect "$ssid" password "$pass"
fi
