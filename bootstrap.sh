#!/bin/bash -i

# Exit on error. Append "|| true" if you expect an error.
set -o errexit

# Tell apt to not prompt anything
export DEBIAN_FRONTEND=noninteractive


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

sudo apt-add-repository -n -y main
sudo apt-add-repository -n -y universe
sudo apt-add-repository -n -y restricted
sudo apt-add-repository -n -y multiverse


# update

sudo apt update
sudo apt dist-upgrade -y


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
  mlocate
  p7zip-full
  powertop
  smem
  software-properties-common
  tree
  whois
)

sudo apt install -y "${BASIC_PACKAGES[@]}"


# setup other repos

wget -qO - https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

wget -qO - https://syncthing.net/release-key.gpg | sudo tee /usr/share/keyrings/syncthing-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/sublimetext-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublimetext.list

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

wget -qO - https://repo.nordvpn.com/gpg/nordvpn_public.asc | sudo gpg --dearmor -o /usr/share/keyrings/nordvpn-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nordvpn-archive-keyring.gpg] https://repo.nordvpn.com/deb/nordvpn/debian stable main" | sudo tee /etc/apt/sources.list.d/nordvpn.list

wget -qO - https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/githubcli.list

sudo add-apt-repository -n -y ppa:fish-shell/release-3
sudo add-apt-repository -n -y ppa:git-core/ppa
sudo add-apt-repository -n -y ppa:inkscape.dev/stable
sudo add-apt-repository -n -y ppa:mozillateam/firefox-next
sudo add-apt-repository -n -y ppa:papirus/papirus
sudo add-apt-repository -n -y ppa:peek-developers/stable


# Replace firefox snap with firefox PPA

sudo snap disable firefox
sudo snap remove --purge firefox
sudo apt autoremove -y firefox
echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam-firefox-next
Pin-Priority: 750

Package: firefox*
Pin: release o=LP-PPA-mozillateam-ppa
Pin-Priority: 550

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozillateamppa > /dev/null


# install Ubuntu packages

APT_PACKAGES=(
  aspell
  aspell-en
  aspell-es
  bleachbit
  chrome-gnome-shell
  code
  containerd.io
  deluge
  docker-ce
  docker-ce-cli
  docker-compose-plugin
  firefox
  fish
  flatpak
  gdebi
  gh
  git-extras
  gitk
  gnome-software
  gnome-software-plugin-flatpak
  gnome-tweaks
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
  peek
  sublime-text
  synaptic
  syncthing
  ubuntu-restricted-extras
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
  fonts-powerline
  fonts-roboto
)

sudo apt update
sudo apt install -y "${APT_PACKAGES[@]}" "${FONT_FAMILIES[@]}"


# Flatpak

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

FLATPAK_PACKAGES=(
  ca.desrt.dconf-editor
  com.mattjakeman.ExtensionManager
  com.spotify.Client
  de.haeckerfelix.Fragments
  io.bassi.Amberol
  io.github.realmazharhussain.GdmSettings
  io.mpv.Mpv
  org.gimp.GIMP
  org.gnome.baobab
  org.gnome.Boxes
  org.gnome.clocks
  org.gnome.gitg
  org.gnome.SoundRecorder
  org.gnome.TextEditor
  org.telegram.desktop
  us.zoom.Zoom
)

flatpak install -y --noninteractive flathub "${FLATPAK_PACKAGES[@]}"


# Snaps

SNAP_PACKAGES=(
  vlc
)

sudo snap install "${SNAP_PACKAGES[@]}"


# setup node env

wget -qO - https://git.io/n-install | bash -s -- -y lts
source ~/.bashrc

NPM_PACKAGES=(
  pnpm
  yarn
)

npm -g install "${NPM_PACKAGES[@]}"


# setup golang env

wget -qO - https://git.io/g-install | sh -s -- -y fish bash
source ~/.bashrc


# fish and fisher

fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
gh completion -s fish > ~/.config/fish/completions/gh.fish


# remove the update notifications and cleanup orphan packages

sudo apt remove -y update-notifier update-manager
sudo apt autoremove -y
sudo apt autoclean -y
