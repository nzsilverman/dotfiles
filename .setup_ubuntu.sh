#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Updating the system...${NC}"
sudo apt update
sudo apt upgrade -y
echo -e "${GREEN}Updated the system packages${NC}"

echo -e "${YELLOW}Setting up package manager access...${NC}"
# Setup sublime text and sublime merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list


sudo add-apt-repository -y ppa:deadsnakes/ppa 
sudo add-apt-repository -y ppa:hluk/copyq

echo -e "${GREEN}Finished setting up package manager access ${NC}"

echo -e "${YELLOW}Installing useful system wide packages...${NC}"
sudo apt update
sudo apt install -y \
  apt-transport-https \
  zsh \
  vim-gtk3 \
  git \
  gnome-tweaks \
  curl \
  terminator \
  python3.11-full \
  python3.12-full \
  python3.13-full \
  compizconfig-settings-manager \
  chrome-gnome-shell \
  sublime-text \
  sublime-merge \
  copyq \
  cowsay \
  bat

echo -e "${GREEN}Finished installing useful system wide packages${NC}"

echo -e "${YELLOW}Installing fzf${NC}"
# Install fzf from source because the version in apt is outdated and does not
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --key-bindings --no-update-rc
echo -e "${GREEN}Installed fzf${NC}"

echo -e "${YELLOW}Installing pip${NC}"
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13
echo -e "${GREEN}Pip installed${NC}"

echo -e "${YELLOW}Setting up shell. This will ask for your password!${NC}"
# If a ~/.zshrc_local file exists, it will not be overwritten
# The ~/.zshrc expects a ~/.zshrc_local file for machine specific overrides
# that are not shared in git
touch ~/.zshrc_local
chsh -s "$(which zsh)"
# Use the zsh pure theme
rm -rf "$HOME/.zsh"
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
echo -e "${GREEN}Finished setting up shell${NC}"

echo -e "${YELLOW}Adjusting system settings to your liking${NC}"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Control>Tab', '<Alt>Tab']"
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['']"
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-sage'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-sage'
echo -e "${YELLOW}System settings updated just how you like!${NC}"

echo -e "${YELLOW}Setting up git preferences${NC}"
~/.setup_git_preferences.sh
echo -e "${GREEN}Git preferences setup${NC}"

echo -e "${GREEN}SUCCESS!${NC}"
cowsay "System is configured!"
