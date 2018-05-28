#!/usr/bin/env bash

SETUP_DIR="$(dirname $0)"

# create symlinks

source "$SETUP_DIR/DOTFILES_LINKS.sh"

setup_links() {
  for file in "${!DOTFILES_LINKS[@]}"; do
    local SRC_PATH="$SETUP_DIR/$file"
    local DST_PATH="${DOTFILES_LINKS[$file]}"
    local DST_DIR="$(dirname $DST_PATH)"

    if [[ -f "$SRC_PATH" ]]; then
      echo INFO: "Linking $SRC_PATH in $DST_PATH"
      mkdir -p "$DST_DIR"
      ln -s -f "$SRC_PATH" "$DST_PATH"
    else
      echo ERROR: "$SRC_PATH doesn't exist"
    fi
  done
}

setup_links

exit 0


# install cli essentials

BASIC_PACKAGES=(
  apt-transport-https
  binutils
  bison
  build-essential
  ca-certificates
  curl
  gcc
  git
  htop
  jq
  lm-sensors
  make
  powertop
  smem
  software-properties-common
  tree
)

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y "${BASIC_PACKAGES[@]}"


# setup Ubuntu repos

wget -qO - https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo add-apt-repository ppa:mozillateam/firefox-next

sudo add-apt-repository ppa:fish-shell/release-2

sudo add-apt-repository ppa:otto-kesselgulasch/gimp

sudo add-apt-repository ppa:snwh/pulp

sudo add-apt-repository ppa:tista/adapta


# install Ubuntu packages

USERLAND_PACKAGES=(
  adapta-gtk-theme
  bleachbit
  chromium-browser
  code-insiders
  firefox
  fish
  gdebi
  gimp
  gimp-gmic
  gitg
  gitk
  gmic
  inkscape
  network-manager-openvpn
  network-manager-openvpn-gnome
  openvpn
  paper-cursor-theme
  paper-gtk-theme
  paper-icon-theme
  sublime-text
  syncthing
  ubuntu-restricted-extras
  vlc
  xdotool
)

sudo apt update
sudo apt install -y "${USERLAND_PACKAGES[@]}"

sudo snap install asciinema --classic
sudo snap install atom
sudo snap install skype --classic
sudo snap install spotify
sudo snap install telegram-desktop


# setup node env

wget -qO - https://git.io/n-install | bash -s -- -y latest

source ~/.bashrc

NPM_PACKAGES=(
  eslint
  flow-bin
  stylelint
  typescript
)

npm -g install "${NPM_PACKAGES[@]}"

# setup golang env


# git-extras

wget -qO - https://git.io/git-extras-setup | sudo bash -s

# hub


# fish and fisher

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c 'fisher up'
