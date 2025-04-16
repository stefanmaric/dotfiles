#!/bin/bash -i

# Exit on error. Append "|| true" if you expect an error.
set -o errexit

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

# Create symlinks. This should be done early.
setup_links() {
  source "$SETUP_DIR/DOTFILES_LINKS.sh"

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

# Cross-platform util to find shell config paths.
get_dotfile_for_shell() {
  case "$1" in
    bash)
      if [ "$(uname | tr '[:upper:]' '[:lower:]')" = "darwin" ]; then
        echo "$HOME/.bash_profile"
      else
        echo "$HOME/.bashrc"
      fi
      ;;
    fish) echo "$HOME/.config/fish/config.fish" ;;
    zsh) echo "$HOME/.zshrc" ;;
    csh) echo "$HOME/.cshrc" ;;
    tcsh) echo "$HOME/.tcshrc" ;;
    ash | dash)
      if [ -z "${ENV:-}" ] || [ ! -f "$ENV" ]; then
        error_and_abort "for ash and dash, the \$ENV var must be properly configured"
      else
        echo "$ENV"
      fi
      ;;
  esac
}


# This is for stuff when using ubuntu as the actual OS vs ubuntu inside WSL
ubuntu_userland() {
  # setup other repositories
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimetext-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/sublimetext-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublimetext.list

  wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

  wget -qO - https://repo.nordvpn.com/gpg/nordvpn_public.asc | sudo gpg --dearmor -o /usr/share/keyrings/nordvpn-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/nordvpn-archive-keyring.gpg] https://repo.nordvpn.com/deb/nordvpn/debian stable main" | sudo tee /etc/apt/sources.list.d/nordvpn.list

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
' | sudo tee /etc/apt/preferences.d/mozillateamppa >/dev/null

  # install Ubuntu packages
  APT_PACKAGES=(
    aspell
    aspell-en
    aspell-es
    bleachbit
    chrome-gnome-shell
    code
    deluge
    firefox
    flatpak
    gdebi
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
    com.github.wwmm.easyeffects
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

  sudo snap refresh
  sudo snap install "${SNAP_PACKAGES[@]}"
}

# This is the base Ubuntu setup, used for both, Ubuntu as desktop OS and Ubuntu inside WSL.
setup_ubuntu() {
  # enable all Ubuntu repos
  sudo apt-add-repository -n -y main
  sudo apt-add-repository -n -y universe
  sudo apt-add-repository -n -y restricted
  sudo apt-add-repository -n -y multiverse

  # setup other repositories
  wget -qO - https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

  wget -qO - https://syncthing.net/release-key.gpg | sudo tee /usr/share/keyrings/syncthing-archive-keyring.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

  wget -qO - https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/githubcli.list

  sudo add-apt-repository -n -y ppa:fish-shell/release-3
  sudo add-apt-repository -n -y ppa:git-core/ppa

  # install cli essentials
  BASIC_PACKAGES=(
    apt-transport-https
    aptitude
    binutils
    bison
    build-essential
    ca-certificates
    containerd.io
    curl
    docker-ce
    docker-ce-cli
    docker-compose-plugin
    fish
    gcc
    gh
    git
    git-extras
    gitk
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
    syncthing
    tree
    whois
  )

  sudo apt update
  sudo apt dist-upgrade -y
  sudo apt install -y "${BASIC_PACKAGES[@]}"

  if grep -qvEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    # if running outside of WSL, install userland packages
    ubuntu_userland
  fi

  # remove the update notifications and cleanup orphan packages
  sudo apt remove -y update-notifier update-manager
  sudo apt autoremove -y
  sudo apt autoclean -y

  sudo usermod -s $(which fish) $USERNAME
}

# The userland Fedora setup.
setup_fedora() {
  # Additional repos
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

  RPM_PACKAGES=(
    automake
    binutils
    bison
    bleachbit
    ca-certificates
    code
    curl
    dconf
    deluge
    fish
    gcc
    gh
    gimp
    git-extras
    gitg
    gitk
    gnome-tweaks
    google-chrome-stable
    gparted
    htop
    inkscape
    jq
    langpacks-de
    langpacks-en
    langpacks-es
    lm_sensors
    make
    mpv
    p7zip
    plocate
    powertop
    smem
    syncthing
    vlc
    whois
  )

  sudo dnf install -y "${RPM_PACKAGES[@]}"

  # Enable full flathub
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  FLATPAK_PACKAGES=(
    com.github.wwmm.easyeffects
    com.mattjakeman.ExtensionManager
    de.haeckerfelix.Fragments
    io.bassi.Amberol
    me.iepure.devtoolbox
    io.github.realmazharhussain.GdmSettings
    org.telegram.desktop
  )

  flatpak install -y --noninteractive flathub "${FLATPAK_PACKAGES[@]}"

  sudo dnf upgrade -y --refresh

  sudo usermod -s $(which fish) $USERNAME
}

setup_macos() {
  touch "$HOME/.bash_profile"

  BREW_CLI_PACKAGES=(
    bash
    curl
    fish
    gh
    git
    git-extras
    git-gui
    htop
    jq
    p7zip
    syncthing
    terminal-notifier
    tree
    wget
  )

  brew install "${BREW_CLI_PACKAGES[@]}"

  BREW_CASK_PACKAGES=(
    alt-tab
    bitwarden
    clocker
    dbeaver-community
    firefox
    google-chrome
    kap
    keepingyouawake
    kitty
    libreoffice
    maccy
    mongodb-compass
    mos
    orbstack
    rectangle
    stats
    visual-studio-code
  )

  brew install --cask "${BREW_CASK_PACKAGES[@]}"

  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)
  echo 'eval (/opt/homebrew/bin/brew shellenv)' >> $(get_dotfile_for_shell fish)
}

unpackaged() {
  # setup node env
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  source $(get_dotfile_for_shell bash)
  pnpm completion fish > ~/.config/fish/completions/pnpm.fish
  pnpm env use --global lts
  echo 'set -gx PNPM_HOME $HOME/.local/share/pnpm; set -gx PATH $PATH $PNPM_HOME' >> $(get_dotfile_for_shell fish)

  # setup golang env
  wget -qO - https://git.io/g-install | sh -s -- -y fish bash
  source $(get_dotfile_for_shell bash)

  # fish and fisher
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  git checkout -- fish/fish_plugins
  fish -c 'fisher update'
  gh completion -s fish > ~/.config/fish/completions/gh.fish

  # pgkx for everything else
  curl https://pkgx.sh | sh
}


init() {
  setup_links

  if [ "$(uname | tr '[:upper:]' '[:lower:]')" = "darwin" ]; then
    setup_macos
  else
    source /etc/os-release

    case $ID in
    ubuntu)
      export DEBIAN_FRONTEND=noninteractive
      setup_ubuntu
      ;;
    fedora)
      setup_fedora
      ;;
    esac
  fi

  unpackaged
}

init
