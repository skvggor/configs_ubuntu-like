#!/bin/bash

set -euo pipefail

mkdir -pv ~/.config/{pulse,lsd,fish,darktable,zellij,alacritty,starship,konsole}
mkdir -pv ~/Google\ Drive
mkdir -pv ~/Projects/{personal,work}

sudo pacman -Syu --needed base-devel git curl

sudo fc-cache -f -v

sudo pacman -S --needed \
  cheese \
  cmake \
  cmatrix \
  darktable \
  fish \
  flameshot \
  gimp \
  go \
  inkscape \
  jq \
  konsole \
  krita \
  micro \
  net-tools \
  nodejs \
  npm \
  obs-studio \
  solaar \
  vlc

if ! command -v unzip &>/dev/null; then
  sudo pacman -S --needed unzip
fi

if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

yay -S --noconfirm \
  lsd \
  ttf-ms-fonts \
  microsoft-edge-stable-bin \
  google-chrome \
  visual-studio-code-insiders-bin \
  rio-git \
  atuin \
  nitch

sudo pacman -S --needed docker
# sudo systemctl start docker.service
# sudo systemctl enable docker.service
# sudo groupadd docker || true
# sudo usermod -aG docker $USER
# newgrp docker

sudo pacman -S --needed starship

sudo pacman -S --needed rustup
rustup default stable

sudo pacman -S --needed zellij zoxide bat alacritty

sudo npm install -g n npm
sudo n lts

sudo npm install -g begynner \
  easy-rename \
  gtop \
  localtunnel \
  svgo \
  vercel

current_dir=$(pwd)

mkdir -p ~/temp
wget "https://github.com/ryanoasis/nerd-fonts/archive/refs/heads/master.zip" -O ~/temp/nerd-fonts.zip
unzip ~/temp/nerd-fonts.zip -d ~/temp
cd ~/temp/nerd-fonts-master
bash install.sh

cd $current_dir

cp -rv .gitconfig ~/.gitconfig
cp -rv starship.toml ~/.config/
cp -rv fish/config.fish ~/.config/fish/
cp -rv fish/zoxide-conf.fish ~/.config/fish/
cp -rv lsd/config.yaml ~/.config/lsd/
cp -rv pulse.conf ~/.config/pulse/daemon.conf
cp -rv alacritty ~/.config/
cp -rv darktable ~/.config/
cp -rv konsole ~/.local/share/
cp -rv SimpleScreenRecorder/.ssr ~/

unzip -o obs-studio.zip -d ~/.config/obs-studio

chsh -s $(which fish)

sudo update-desktop-database

rm -rf ~/temp

exit 0
