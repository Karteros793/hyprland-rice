# Hyprland rice
Встановлення: ./install.sh

SUPER+Enter kitty | SUPER+D лаунчер | SUPER+W шпалери | SUPER+N Wi-Fi меню | SUPER+Q наступні шпалери | SUPER+C закрити вікно | SUPER+X меню живлення | SUPER+L блокування екрана
SUPER+1..6 воркспейси | Alt+Shift EN/UA | SUPER+Shift+R перезавантажити











sudo pacman -S --needed git


git clone https://github.com/Karteros793/hyprland-rice.git


cd hyprland-rice



bash install.sh


chmod +x ~/.config/scripts/*.sh




mkdir -p ~/Pictures/wallpapers



cp /шлях/до/картинок/* ~/Pictures/wallpapers/




killall waybar; waybar &
