#!/bin/bash

# For Aur Helper install Paru
echo "### Installing paru as AUR Helper"
mkdir $HOME/Downloads/_cloned-repos
cd $HOME/Downloads/_cloned-repos
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# First install Oh-My-Zsh
echo "### Installing..."
echo "### Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "### First step done"
echo "### Installing Required Packages"
paru -S python ffmpeg pulseaudio pulseaudio-alsa alsa-utils dunst xclip scrot  \
thunar thunar-archive-plugin thunar-volman ffmpegthumbnailer tumbler w3m       \
viewnior mpv neofetch htop xsettingsd picom-jonaburg-git rofi rsync firefox    \
ranger python-pip noto-fonts-emoji noto-fonts-cjk python-pillow-git xwallpaper \
exa bat file-roller geany geany-plugins gvfs gvfs-mtp htop kitty wal-git       \
lxappearance

echo "### Second step done"
echo "### Installing Oh-My-Zsh Plugins"
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "### Installing Hypr WM | First Install Required Packages"
sudo pacman -S --needed cairo gdb ninja gcc cmake libxcb xcb-proto xcb-util xcb-util-cursor xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm xcb-util-xrm gtkmm gtk4 gtkmm3 

echo "### Cloning Hypr"
cd $HOME/Downloads/_cloned-repos
git clone https://github.com/vaxerski/Hypr
cd Hypr
make clear && make release

echo "### Copying files..."
cd $HOME/Downloads/_cloned-repos/Hypr
sudo cp ./build/Hypr /usr/bin
sudo cp ./example/hypr.desktop /usr/share/xsessions

# Syncing my Dotfiles to ~/
echo "### Sync Dotfiles"
cd $HOME/dotfiles/
rsync -avxHAXP --exclude '.git*' .* ~/

echo "### Copying Icons
pushd ~/.icons/ && \
    tar -xJf Papirus-Custom.tar.xz && tar -xJf Papirus-Dark-Custom.tar.xz && \
    sudo ln -vs ~/.icons/Papirus-Custom /usr/share/icons/
    sudo ln -vs ~/.icons/Papirus-Dark-Custom /usr/share/icons/
    rm -rf *.tar.xz
popd

echo "### Refresh Fonts
fc-cache -rv
