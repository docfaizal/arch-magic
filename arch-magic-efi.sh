# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to docfaizal's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
pacstrap /mnt base base-devel linux-lts linux-firmware sed vim git acpi
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit

#part2
printf '\033c'
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
# echo "Hostname: "
# read hostname
echo "yourbetterone" > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       yourbetterone.localdomain yourbetterone" >> /etc/hosts
# Bootloader and some important utilities
pacman -S --needed networkmanager grub linux-lts-headers dosfstools xdg-utils brightnessctl \
efibootmgr fontconfig udisks2 dialog parcellite mtools duf tealdeer gvfs xdg-user-dirs libmtp xdg-desktop-portal-gtk aria2 cowsay pacman-contrib libconfig libva-mesa-driver vdpauinfo \
xf86-video-amdgpu xf86-video-ati libva-vdpau-driver lxsession lxappearance-gtk3 qt5ct volumeicon ncdu exa gtk-engine-murrine libva-utils mesa-vdpau gst-libav \
zip dash gvfs-mtp unzip unrar p7zip maim rsync imagemagick android-file-transfer \
reflector mpv dunst jq fish ntfs-3g fzf android-tools
# Xorg package selection
pacman -S xorg
# Browser 
pacman -S --needed firefox mailcap
# Sound packages
pacman -S --needed pulseaudio pulseaudio-alsa pamixer alsa-utils alsa-plugins
# fonts
pacman -S --noconfirm ttf-roboto ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts noto-fonts-emoji noto-fonts-cjk
# Add btrfs in module section
vim /etc/mkinitcpio.conf 
mkinitcpio -P
passwd
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=archlinux
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
# echo "Enter Username: "
# read username
useradd -m -g users -G wheel,storage,audio,video,network,power -s /bin/bash docfaizal
passwd docfaizal
# Installing AUR helper
# sudo -u docfaizal git clone https://aur.archlinux.org/yay-bin.git
# cd yay-bin/
# sudo -u docfaizal makepkg -si

# adding chaotic AUR
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "[chaotic-aur]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist"  >> /etc/pacman.conf
sleep 2s
# chaotic aur packages
pacman -Sy
pacman -S --needed brave-bin github-desktop g4music cava
# Final step
echo "Installation Finish Reboot now and run xdg-user-dirs-update"
exit 