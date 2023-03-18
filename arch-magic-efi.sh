# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to docfaizal's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
pacstrap /mnt base base-devel linux-lts linux-firmware sed vim btrfs-progs git
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
pacman --noconfirm -S networkmanager grub linux-lts-headers dosfstools \
efibootmgr fontconfig udisks2 dialog ocs-url parcellite mtools duf
# Xorg package selection
pacman -S xorg
# Sound packages
pacman -S pulseaudio pulseaudio-alsa alsa-utils alsa-plugins
# Add btrfs in module section
vim /etc/mkinitcpio.conf 
mkinitcpio -P
passwd
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo "Enter Username: "
# read username
useradd -m -g users -G wheel,storage,audio,video,network -s /bin/bash docfaizal
passwd docfaizal
# Installing AUR helper
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
sudo -u docfaizal makepkg -si
echo "Installation Finish Reboot now"
exit 
