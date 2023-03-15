# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to docfaizal's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
pacstrap /mnt base base-devel linux-lts linux-firmware sed
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
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
pacman --noconfirm -S networkmanager grub linux-lts-headers duf efibootmgr os-prober
mkinitcpio -P
passwd
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
# xorg-pkg-select
pacman -S xorg

pacman -S --noconfirm --needed noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono \
pulseaudio pulseaudio-alsa alsa-utils ttf-joypixels ttf-font-awesome \
sxiv tcc mpv gst-libav zathura zathura-pdf-mupdf ffmpeg imagemagick libmtp android-file-transfer\
fzf awesome-terminal-fonts ttf-roboto man-db clipmenu xclip gvfs gnome-keyring maim \
zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl appimagelauncher \
dosfstools mailcap ntfs-3g git fish gvfs-mtp gvfs-gphoto2 \
arc-gtk-theme rsync pavucontrol qutebrowser dash jq aria2 cowsay pacman-contrib \
networkmanager pamixer xdg-user-dirs libconfig libva-mesa-driver vdpauinfo radeontop \
xf86-video-amdgpu xf86-video-ati libva-vdpau-driver libva-utils mesa-vdpau ttf-nerd-fonts-symbols-2048-em-mono

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read username
useradd -m -g users -G wheel,storage,power,audio,video,network -s /bin/bash $username 
passwd $username
echo "Installation Finish Reboot now"
exit 
