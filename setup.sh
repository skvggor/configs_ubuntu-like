#!/bin/bash

# Install Nix
# sh <(curl -L https://nixos.org/nix/install) --daemon

nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
nix-channel --update

# design
# nix-env -iA nixpkgs.gimp
# nix-env -iA nixpkgs.inkscape
# nix-env -iA nixpkgs.krita

# development
# nix-env -iA nixpkgs.git
NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixos.vscode

# ln -s /home/$USER/.nix-profile/share/applications/* /home/$USER/.local/share/applications/
# ln -s /home/$USER/.nix-profile/share/icons/hicolor/256x256/apps/* /home/$USER/.local/share/icons/hicolor/scalable/apps/
