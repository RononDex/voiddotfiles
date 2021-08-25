#!/bin/bash
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cp $scriptDir/overrides/packages.list ~/packages/xbps-mini-builder/packages.list
sudo cp $scriptDir/overrides/lightdm.conf /etc/lightdm/lightdm.conf
sudo cp $scriptDir/overrides/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf
cp $scriptDir/overrides/polybar/constants ~/.config/polybar/constants
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp $scriptDir/overrides/xorg/20-keybord.conf /etc/X11/xorg.conf.d/20-keyboard.conf
sudo cp $scriptDir/overrides/xorg/30-mouse.conf /etc/X11/xorg.conf.d/30-mouse.conf
mkdir -p ~/.ssh
cp $scriptDir/overrides/ssh/authorized_keys ~/.ssh/authorized_keys
sudo cp $scriptDir/overrides/ssh/sshd_config /etc/ssh/sshd_config
cp $scriptDir/overrides/mimeapps.list ~/.local/share/applications/mimeapps.list
sudo cp $scriptDir/overrides/mimeapps.list /usr/share/applications/defaults.list
sudo rm /usr/share/applications/mimeinfo.cache
rm ~/.local/share/applications/mimeinfo.cache
cp $scriptDir/overrides/dcronConfig ~/.config/customCronConfig
sudo cp $scriptDir/overrides/networking/interfaces /etc/network/interfaces
sudo mkdir -p /etc/mdadm
sudo cp $scriptDir/overrides/mdadm/mdadm.conf /etc/mdadm/mdadm.conf

mkdir ~/.i3
mkdir ~/.i3/workspaces
mkdir ~/.i3/scripts

cp $scriptDir/overrides/.i3/workspaces/load-workspaces.sh ~/.i3/workspaces/load-workspaces.sh
cp $scriptDir/overrides/.i3/workspaces/workspace-1.json ~/.i3/workspaces/workspace-1.json
cp $scriptDir/overrides/.i3/scripts/launch-autostart.sh ~/.i3/scripts/launch-autostart.sh

echo "Installing stuff..."
sudo xbps-install -y linux-firmware-amd network-manager-applet lightdm lightdm-webkit2-greeter light-locker firefox arc-theme arc-icon-theme nautilus 
sudo xbps-install -y i3-gaps dunst libnotify notification-daemon dmenu pavucontrol flameshot nextcloud-client cabextract xf86-input-evdev
sudo xbps-install -y qemu virt-manager php php-gd php-mysql php-intl nginx certbot certbot-nginx
sudo xbps-install -y polybar python3-vdf protontricks vscode ckb-next screenkey vscode gnuplot
sudo xbps-install -y xf86-video-amdgpu amdvlk mesa cryptsetup tpm2-tss
sudo xbps-install -y nomacs breeze breeze-cursors
sudo xbps-install -y mdadm

InstallXorg
InstallLitarvanLightDmTheme
InstallYubiKeyStuff
SetupDotnet

echo "Setting default apps overrides"
xdg-mime default nomacs.desktop image/jpeg
xdg-mime default nomacs.desktop image/png
xdg-mime default nomacs.desktop image/tiff
xdg-mime default nomacs.desktop image/jpg

echo "Installing restricted packages ..."
InstallRestrictedPackageFromCache hostdir/binpkgs/nonfree teams-bin
InstallRestrictedPackageFromCache hostdir/binpkgs/nonfree pritunl-client
InstallRestrictedPackageFromCache hostdir/binpkgs/nonfree teamspeak3

echo "Enabling services ..."
EnableService lightdm
EnableService sshd

crontab ~/.config/customCronConfig

sudo groupadd ssh_access

currentUser=$(whoami)
sudo usermod -a -G lp ${currentUser}
sudo usermod -a -G input ${currentUser}
sudo usermod -a -G video ${currentUser}
sudo usermod -a -G uucp ${currentUser}
sudo usermod -a -G users ${currentUser}
sudo usermod -a -G audio ${currentUser}
sudo usermod -a -G radio ${currentUser}
sudo usermod -a -G ssh_access ${currentUser}

chmod +x ~/.scripts/bashprofile
chmod +x ~/.scripts/xprofile
chmod +x ~/.i3/workspaces/load-workspaces.sh
