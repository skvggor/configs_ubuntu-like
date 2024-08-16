#!/bin/bash

set -euo pipefail

mkdir -pv ~/.config/{pulse,lsd,fish,darktable,zellij,alacritty,starship,konsole}
mkdir -pv ~/Google\ Drive
mkdir -pv ~/Projects/{personal,work}

sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl git

# UPDATE FONT CACHE
sudo fc-cache -f -v

# DESIGN AND MULTIMEDIA
sudo apt install -y \
  cheese \
  darktable \
  gimp \
  inkscape \
  krita \
  obs-studio \
  simplescreenrecorder \
  ttf-mscorefonts-installer \
  vlc

# SYSTEM AND DEVELOPMENT
sudo apt install -y \
  build-essential \
  cmake \
  cmatrix \
  fish \
  golang-go \
  jq \
  konsole \
  lsd \
  micro \
  net-tools \
  nodejs

# - docker
sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update -y && sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io
# // ------------------------------

# - configure and start
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo chmod 666 /var/run/docker.sock
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# // ------------------------------

# - starship
curl -sS https://starship.rs/install.sh | sh
# // ------------------------------

# - dbeaver
sudo wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update -y && sudo apt install dbeaver-ce -y
# // ------------------------------

# - nitch
wget https://raw.githubusercontent.com/unxsh/nitch/main/setup.sh && sh setup.sh
# // ------------------------------

# - rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default stable

# - cargo packages
sudo apt install \
  cmake \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  python3

cargo install \
  alacritty \
  bat \
  rioterm \
  zellij \
  zoxide
# // ------------------------------

# - atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# // ------------------------------

# -- Alacritty config
git clone https://github.com/alacritty/alacritty ~/temp/alacritty
cd ~/temp/alacritty
sudo cp -rv extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
# // ------------------------------

# -- Rio config
git clone https://github.com/raphamorim/rio ~/temp/rio
cd ~/temp/rio
sudo cp -rv misc/logo.svg /usr/share/pixmaps/Rio.svg
sudo desktop-file-install misc/rio.desktop
# // ------------------------------

sudo update-desktop-database

# UTILITIES
sudo apt install -y \
  flameshot \
  solaar

# INSTALL CONFIGURATIONS
cp -rv .gitconfig ~/
cp -rv starship.toml ~/.config/
cp -rv fish/config.fish ~/.config/fish/
cp -rv fish/zoxide-conf.fish ~/.config/fish/
cp -rv lsd/config.yaml ~/.config/lsd/
cp -rv pulse.conf ~/.config/pulse/daemon.conf
cp -rv alacritty ~/.config/
cp -rv darktable ~/.config/
cp -rv konsole ~/.local/share/
cp -rv SimpleScreenRecorder/.ssr ~/

# SET FISH AS DEFAULT SHELL
chsh -s $(which fish)

# NPM PACKAGES
sudo apt install npm
sudo npm i -g n npm

# - set nodejs to LTS
sudo n lts

sudo npm i -g begynner \
  easy-rename \
  gtop \
  localtunnel \
  svgo \
  vercel

# - nerd fonts
wget "https://github.com/ryanoasis/nerd-fonts/archive/refs/heads/master.zip" -O ~/temp/nerd-fonts.zip
unzip ~/temp/nerd-fonts.zip
cd ~/temp/nerd-fonts
bash install.sh
# // ------------------------------

# - microsoft edge
wget "https://go.microsoft.com/fwlink?linkid=2149051" -O ~/temp/edge.deb
sudo apt install -y ~/temp/edge.deb
# // ------------------------------

# - google chrome
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ~/temp/chrome.deb
sudo apt install -y ~/temp/chrome.deb
# // ------------------------------

# - visual studio code insiders
wget "https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64" -O ~/temp/vscode.deb
sudo apt install -y ~/temp/vscode.deb
# // ------------------------------

rm -rf ~/temp

exit 0
