#!/bin/sh
# ------------------------------
# Arch Linux Install
# ------------------------------
scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. $scriptDir/../../functions/astroFunctions.sh

sudo cp $scriptDir/overrides/lightdm.conf /etc/lightdm/lightdm.conf
sudo cp $scriptDir/overrides/web-greeter.yml /etc/lightdm/web-greeter.yml 
cp $scriptDir/overrides/polybar/constants ~/.config/polybar/constants
sudo cp $scriptDir/overrides/xorg/20-keybord.conf /etc/X11/xorg.conf.d/20-keyboard.conf
sudo cp $scriptDir/overrides/xorg/21-touchpad.conf /etc/X11/xorg.conf.d/21-touchpad.conf
sudo cp $scriptDir/overrides/hosts /etc/hosts
cp $scriptDir/overrides/.i3/workspaces/load-workspaces.sh ~/.i3/workspaces/load-workspaces.sh
cp $scriptDir/overrides/.i3/workspaces/workspace-1.json ~/.i3/workspaces/workspace-1.json
cp $scriptDir/overrides/.i3/scripts/launch-autostart.sh ~/.i3/scripts/launch-autostart.sh
cp $scriptDir/overrides/.Xresources ~/.Xresources
cp $scriptDir/overrides/polybar/launch.sh ~/.config/polybar/launch.sh
sudo cp $scriptDir/overrides/pacman.conf /etc/pacman.conf

sudo pacman -Syy
sudo pacman -Syu --noconfirm

if [ ! -d ~/.omnisharp ]; then
    mkdir ~/.omnisharp
fi

echo "Setting up omnisharp for vscode..."
rm -rf ~/.omnisharp
cp -Raf $scriptDir/../ATLANTIS-Surface/overrides/omnisharp ~/.omnisharp

echo "Installing stuff..."
sudo pacman -Sy i3-gaps nextcloud-client light xf86-input-wacom dunst libnotify notification-daemon vlc dmenu flameshot teamspeak3 blueman qt6-virtualkeyboard wireguard-tools --noconfirm --needed
sudo pacman -Sy texlive-most pulseaudio-bluetooth aspnet-runtime xournalpp remmina signal-desktop freerdp --needed --noconfirm
sudo pacman -Sy nomacs libreoffice mpv breeze breeze-icons libvncserver --needed --noconfirm
sudo pacman -Sy virt-manager qemu onboard chromium xf86-video-vesa --needed --noconfirm
sudo pacman -Syu dotnet-sdk aspnet-runtime aspnet-targeting-pack sof-firmware --needed --noconfirm
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

#SetupDotnet                # Use official dotnet packages instead
SetupWireguardClient
SetupJavaDevEnv
InstallJupyterNotebooks
SetupPythonDev
InstallGrubTheme 

echo "Installing AUR packages..."
InstallAurPackage "nvm" "https://aur.archlinux.org/nvm.git"
InstallAurPackage "mons" "https://aur.archlinux.org/mons.git"
InstallAurPackage "polybar" "https://aur.archlinux.org/polybar.git"
InstallAurPackage "steam-fonts" "https://aur.archlinux.org/steam-fonts.git"
InstallAurPackage "visual-studio-code-bin" "https://aur.archlinux.org/visual-studio-code-bin.git"
InstallAurPackage "breeze-obsidian-cursor-theme" "https://aur.archlinux.org/breeze-obsidian-cursor-theme.git"
# InstallAurPackage "teams" "https://aur.archlinux.org/teams.git"
InstallAurPackage "slack-desktop" "https://aur.archlinux.org/slack-desktop.git"
InstallAurPackage "intel-ivsc-firmware" "https://aur.archlinux.org/intel-ivsc-firmware.git"
InstallAurPackage "intel-ivsc-driver-dkms-git" "https://aur.archlinux.org/intel-ivsc-driver-dkms-git.git"
InstallAurPackage "intel-ipu6-dkms-git" "https://aur.archlinux.org/intel-ipu6-dkms-git.git"
InstallAurPackage "ipu6-camera-bin" "https://aur.archlinux.org/ipu6-camera-bin.git"
InstallAurPackage "intel-ipu6ep-camera-hal-git" "https://aur.archlinux.org/intel-ipu6ep-camera-hal-git.git"
InstallAurPackage "icamerasrc-git" "https://aur.archlinux.org/icamerasrc-git.git"
InstallAurPackage "cvmfs" "https://aur.archlinux.org/cvmfs.git"

echo "Installing screenkey"
sudo pacman -Sy python2-setuptools --needed --noconfirm
InstallAurPackage "python2-distutils-extra" "https://aur.archlinux.org/python2-distutils-extra.git"
InstallAurPackage "screenkey" "https://aur.archlinux.org/screenkey.git"

echo "Enabling services ..."
sudo systemctl enable lightdm.service
sudo systemctl enable iptsd
sudo systemctl enable libvirtd

echo "Setting up shares ..."
SetupAutofsForSmbShare "ATLANTIS-SRV" "Documents" "://10.142.0.1/Documents" "Downloads" "://10.142.0.1/Downloads" "Software" "://10.142.0.1/Software" "Astrophotography" "://10.142.0.1/Astrophotography" "Backup" "://10.142.0.1/Backup"
SetupAutofsForSmbShare "FHNW" "data" "" "://fs.edu.ds.fhnw.ch/data"

echo "Adjust user permissions"
currentUser=$(whoami)
sudo usermod -a -G lp ${currentUser}
sudo usermod -a -G input ${currentUser}
sudo usermod -a -G video ${currentUser}
sudo usermod -a -G uucp ${currentUser}
sudo usermod -a -G users ${currentUser}
sudo usermod -a -G audio ${currentUser}
sudo usermod -a -G libvirt ${currentUser}

chmod +x ~/.scripts/bashprofile
chmod +x ~/.scripts/xprofile
chmod +x ~/.i3/workspaces/load-workspaces.sh

echo "Updating grub config"
sudo cp $scriptDir/overrides/grub/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg  
