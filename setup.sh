#!/bin/bash

mkdir -v ~/.config/{pulse,lsd,fish,darktable}
mkdir ~/Google\ Drive
mkdir -p ~/Projects/me

# Check if the system is Arch-based and install curl
if [[ -f /etc/arch-release ]]; then
  sudo pacman -Syu
  sudo pacman -S curl \
    git \
    docker \
    docker-compose --noconfirm

  yay -S ttf-ms-win11-auto \
    visual-studio-code-insiders-bin --noconfirm
else
  # Add multiverse repository
  sudo add-apt-repository multiverse

  sudo apt update

  sudo apt install -y curl \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    git \
    ttf-mscorefonts-installer
fi

# Update font cache
sudo fc-cache -f -v

# Check if Nix is installed and install it if not
if ! command -v nix-env &>/dev/null; then
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi

nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
nix-channel --update

# design
nix-env -iA nixos.gimp \
  nixos.inkscape \
  nixos.krita

# system and development
nix-env -iA nixos.alacritty \
  nixos.atuin \
  nixos.bat \
  nixos.cmake \
  nixos.cmatrix \
  nixos.docker \
  nixos.docker-compose \
  nixos.fish \
  nixos.git \
  nixos.go \
  nixos.jq \
  nixos.lsd \
  nixos.micro \
  nixos.nettools \
  nixos.nitch \
  nixos.nodejs \
  nixos.rio \
  nixos.rustup \
  nixos.starship \
  nixos.virtualbox \
  nixos.zellij

# NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixos.vscode

# utilities
nix-env -iA nixos.flameshot \
  nixos.gnome.cheese \
  nixos.google-chrome \
  nixos.mplayer \
  nixos.rhythmbox \
  nixos.solaar \
  nixos.vlc \
  nixos.zoxide

# Remove KDE apps shortcuts
sudo rm -rfv ~/.nix-profile/share/applications/*.kde*

# Create symlinks for desktop shortcuts
ln -s /home/$USER/.nix-profile/share/applications/* /home/$USER/.local/share/applications/
ln -s /home/$USER/.nix-profile/share/icons/hicolor/256x256/apps/* /home/$USER/.local/share/icons/hicolor/scalable/apps/

# Install desktop shortcuts
sudo desktop-file-install ~/.nix-profile/share/applications/*
sudo update-desktop-database

# Configure and start Dockerq
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo chmod 666 /var/run/docker.sock
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Install config files
cp -rv fish/config.fish ~/.config/fish/
cp -rv .gitconfig ~/
cp -rv alacritty ~/.config/
cp -rv darktable/styles ~/.config/darktable/styles/
cp -rv pulse.conf ~/.config/pulse/daemon.conf
cp -rv SimpleScreenRecorder/.ssr ~/
cp -rv lsd/config.yaml ~/.config/lsd/

# Set fish as default shell
chsh -s /usr/bin/fish

# Install Node.js packages
sudo npm i -g \
  begynner \
  easy-rename \
  gtop \
  localtunnel \
  n \
  svgo \
  vercel

# Install Nerd Fonts
{
  mkdir ~/temp && cd ~/temp &&
    git clone https://github.com/ryanoasis/nerd-fonts &&
    bash nerd-fonts/install.sh &&
    cd ~ && rm -rf ~/temp
} || {
  echo "Failed to install Nerd Fonts"
}
