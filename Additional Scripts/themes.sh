#!/bin/sh

printf '\033c'
git clone https://github.com/ZorinOS/zorin-desktop-themes.git
cd zorin-desktop-themes/
sudo cp -r * /usr/share/themes/
sleep 2s
git clone https://github.com/ZorinOS/zorin-icon-themes.git
cd zorin-icon-theme/
sudo cp -r * /usr/share/icons/
sleep 2s
