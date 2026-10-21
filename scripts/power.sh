#!/usr/bin/env bash
# Меню живлення (rofi)
THEME="$HOME/.config/rofi/launcher.rasi"
choice=$(printf 'Заблокувати\nВимкнути\nПерезавантажити\nСон\nВийти з сесії\n' | rofi -dmenu -p power -theme "$THEME")
case "$choice" in
  "Заблокувати") hyprlock ;;
  "Вимкнути") systemctl poweroff ;;
  "Перезавантажити") systemctl reboot ;;
  "Сон") systemctl suspend ;;
  "Вийти з сесії") hyprctl dispatch exit ;;
esac
