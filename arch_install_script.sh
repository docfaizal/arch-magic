arch_install_script


# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to docfaizal's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware sed
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt
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
mkinitcpio -P
passwd
pacman --noconfirm -S grub os-prober
grub-install --recheck /dev/sda
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome ttf-nerd-fonts-symbols-2048-em-mono \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db unclutter xclip maim \
     zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
     dosfstools ntfs-3g git fish pipewire pipewire-pulse \
     arc-gtk-theme rsync qutebrowser dash \
     xcompmgr jq aria2 cowsay \
     networkmanager pamixer \
     xdg-user-dirs libconfig

systemctl enable NetworkManager
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "Installation Finish Reboot now"
exit 
