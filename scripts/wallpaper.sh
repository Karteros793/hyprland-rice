#!/usr/bin/env bash
DIR="$HOME/Pictures/wallpapers"
STATE="$HOME/.cache/current_wallpaper"
mkdir -p "$DIR" "$(dirname "$STATE")"

apply() {
  swww img "$1" --transition-type grow --transition-duration 1.2
  echo "$1" > "$STATE"
}

if [[ "$1" == "--restore" ]]; then
  [[ -f "$STATE" ]] && apply "$(cat "$STATE")"
  exit 0
fi

if [[ "$1" == "--next" ]]; then
  mapfile -t files < <(find "$DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort -V)
  [[ ${#files[@]} -eq 0 ]] && exit 0
  cur=$(cat "$STATE" 2>/dev/null)
  idx=-1
  for i in "${!files[@]}"; do [[ "${files[$i]}" == "$cur" ]] && idx=$i; done
  apply "${files[$(( (idx + 1) % ${#files[@]} ))]}"
  exit 0
fi

choice=$(find "$DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) -printf '%f\n' | sort -V |
  while read -r f; do printf '%s\0icon\x1f%s\n' "$f" "$DIR/$f"; done |
  rofi -dmenu -p wallpaper -theme ~/.config/rofi/wallpaper.rasi)

[[ -n "$choice" ]] && apply "$DIR/$choice"
