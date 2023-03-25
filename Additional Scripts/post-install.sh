#!/bin/sh

printf '\033c'
sudo pacman -Sy --needed xorg-server xorg-xinit xorg-xinput pacman-contrib gst-libav rclone aria2 p7zip ffmpeg scrot simplescreenrecorder papirus-icon-theme zip unzip fzf lxappearance xterm mtools dosfstools xorg-xrandr gnome-disk-utility udisks2 xorg-xbacklight xdg-utils unrar xdg-user-dirs pcmanfm gtk-engine-murrine amd-ucode xf86-video-amdgpu gtk2 gtk3 xf86-video-ati gparted mpv qt5ct gvfs ntp-dinit mupdf file-roller bleachbit lxsession
clear
sleep 2s
xdg-user-dirs-update
clear

