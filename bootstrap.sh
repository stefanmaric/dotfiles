#!/bin/bash -i

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

# create symlinks

source "$SETUP_DIR/DOTFILES_LINKS.sh"

setup_links() {
  for file in "${!DOTFILES_LINKS[@]}"; do
    local SRC_PATH="$SETUP_DIR/$file"
    local DST_PATH="${DOTFILES_LINKS[$file]}"
    local DST_DIR="$(dirname "$DST_PATH")"

    if [[ -f "$SRC_PATH" ]]; then
      echo INFO: "Linking $file in $DST_PATH"
      mkdir -p "$DST_DIR"
      ln -s -f "$SRC_PATH" "$DST_PATH"
    else
      echo ERROR: "$SRC_PATH doesn't exist"
    fi
  done
}

setup_links


# enable all Ubuntu repos

sudo apt-add-repository main
sudo apt-add-repository universe
sudo apt-add-repository restricted
sudo apt-add-repository multiverse
sudo add-apt-repository -n -y "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

# update

sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y


# install cli essentials

BASIC_PACKAGES=(
  apt-transport-https
  aptitude
  binutils
  bison
  build-essential
  ca-certificates
  curl
  gcc
  git
  gnupg-agent
  htop
  jq
  lm-sensors
  make
  p7zip-full
  powertop
  smem
  software-properties-common
  tree
  whois
)

sudo DEBIAN_FRONTEND=noninteractive apt install -y "${BASIC_PACKAGES[@]}"


# setup other repos

wget -qO - https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

wget -qO - https://repo.nordvpn.com/gpg/nordvpn_public.asc | sudo apt-key add -
echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" | sudo tee /etc/apt/sources.list.d/nordvpn.list

sudo add-apt-repository -n -y ppa:mozillateam/firefox-next
sudo add-apt-repository -n -y ppa:fish-shell/release-3
sudo add-apt-repository -n -y ppa:papirus/papirus
sudo add-apt-repository -n -y ppa:git-core/ppa


# install Ubuntu packages

USERLAND_PACKAGES=(
  aspell
  aspell-en
  aspell-es
  bleachbit
  chrome-gnome-shell
  chromium-browser
  code
  dconf-editor
  deluge
  docker.io
  firefox
  fish
  gdebi
  gimp
  gitg
  gitk
  gmic
  gnome-clocks
  gnome-sound-recorder
  gnome-tweak-tool
  gnome-usage
  gparted
  hunspell
  hunspell-en-us
  hunspell-es
  network-manager-openvpn
  network-manager-openvpn-gnome
  nordvpn
  openvpn
  papirus-icon-theme
  sublime-text
  synaptic
  peek
  syncthing
  ubuntu-restricted-extras
  vlc
  wspanish
  xdotool
)

FONT_FAMILIES=(
  fonts-cascadia-code
  fonts-firacode
  fonts-inconsolata
  fonts-lato
  fonts-monoid
  fonts-noto
  fonts-open-sans
  fonts-roboto
)

sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y "${USERLAND_PACKAGES[@]}" "${FONT_FAMILIES[@]}"

SNAP_PACKAGES=(
  inkscape
  ksnip
  spotify
  telegram-desktop
)

sudo snap install "${SNAP_PACKAGES[@]}"

# setup node env

wget -qO - https://git.io/n-install | bash -s -- -y lts
source ~/.bashrc

NPM_PACKAGES=(
  eslint
  flow-bin
  pnpm
  prettier
  stylelint
  typescript
  yarn
)

npm -g install "${NPM_PACKAGES[@]}"


# setup golang env

wget -qO - https://git.io/g-install | sh -s -- -y fish bash
source ~/.bashrc


# git-extras

wget -qO - https://git.io/git-extras-setup | sudo bash -s


# hub

go get github.com/github/hub
curl --create-dirs -sSLo ~/.config/fish/completions/hub.fish https://raw.githubusercontent.com/github/hub/master/etc/hub.fish_completion


# fish and fisher

curl --create-dirs -sSLo ~/.config/fish/functions/fisher.fish https://git.io/fisher
fish -c 'fisher'


# docker compose

docker_compose_version="$(curl -sSL https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output '.tag_name')"
curl --create-dirs -sSLo ~/bin/docker-compose "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)"
chmod +x ~/bin/docker-compose
curl --create-dirs -sSLo ~/.config/fish/completions/docker-compose.fish https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish


# remove the update notifications and cleanup orphan packages

sudo DEBIAN_FRONTEND=noninteractive apt remove -y update-notifier update-manager
sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y
sudo DEBIAN_FRONTEND=noninteractive apt autoclean -y
