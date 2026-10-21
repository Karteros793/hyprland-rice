#!/usr/bin/env bash
set -e
echo "==> Встановлення пакетів (Arch)"
sudo pacman -S --needed hyprland waybar rofi kitty fish cava btop htop fastfetch \
  ttf-jetbrains-mono-nerd pavucontrol wireplumber grim slurp wl-clipboard \
  brightnessctl xdg-desktop-portal-hyprland networkmanager network-manager-applet hyprlock
sudo pacman -S --needed swww || yay -S --needed awww || true

sudo systemctl enable --now NetworkManager

echo "==> Копіювання конфігів"
CFG="$HOME/.config"
for d in hypr waybar rofi kitty cava scripts; do
  [[ -e "$CFG/$d" ]] && mv "$CFG/$d" "$CFG/$d.bak.$(date +%s)"
  cp -r "$(dirname "$0")/$d" "$CFG/$d"
done
mkdir -p "$HOME/Pictures/wallpapers"
echo "==> Готово! Поклади шпалери в ~/Pictures/wallpapers і перезайди в Hyprland."
