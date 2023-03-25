#!/bin/sh

printf '\033c'
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
makepkg -si
echo "YAY-Done"
sleep 2s
yay -S pacseek-bin fm6000 picom-animations-git ttf-google-sans ani-cli
clear
sleep 3s
mkdir wallpapers
cd wallpapers/
git clone https://github.com/linuxdotexe/nordic-wallpapers.git
cd ..
echo "Wallpapers and fonts done"
yay -S catppuccin-gtk-theme-mocha catppuccin-gtk-theme-macchiato catppuccin-gtk-theme-frappe papirus-folders-catppuccin-git
