#!/bin/bash
sudo mkdir -p ~/.local/share/fonts

cd /tmp
fonts=( 
"FiraCode"  
"Iosevka"  
"UbuntuMono"
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip
    sudo unzip $font.zip -d $HOME/.local/share/fonts/$font/
    rm $font.zip
done
fc-cache -vf
