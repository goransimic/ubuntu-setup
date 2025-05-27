#!/bin/bash

ROOT_DIR=$HOME/.local/share/ubuntu-setup
CONFIGS_DIR=$ROOT_DIR/configs
EXTENSIONS_DIR=$ROOT_DIR/extensions
ICONS_DIR=$ROOT_DIR/icons
LAUNCHERS_DIR=$ROOT_DIR/launchers
SCRIPTS_DIR=$ROOT_DIR/scripts
SERVICES_DIR=$ROOT_DIR/services

RUNNING_GNOME=$([[ $XDG_CURRENT_DESKTOP == *"GNOME"* ]] && echo true || echo false)

setup_system() {
  echo "Setup System..."
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y curl fonts-firacode git
  sudo cp $CONFIGS_DIR/sysctl.conf /etc/sysctl/local.conf
  sudo sysctl -qp
  cp $CONFIGS_DIR/bashrc ~/.bashrc
  cp $CONFIGS_DIR/inputrc ~/.inputrc
  cp $CONFIGS_DIR/aliases ~/.aliases

  if $RUNNING_GNOME; then
    sudo apt-get install -y dconf-editor flatpak gnome-shell-extension-manager gnome-sushi gnome-tweaks
    sudo ln -sf /var/lib/snapd/snap /snap
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    gsettings set org.gnome.desktop.app-folders folder-children "['']"
    gsettings set org.gnome.desktop.interface clock-show-date false
    gsettings set org.gnome.desktop.notifications show-in-lock-screen false
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.privacy report-technical-problems false
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
    gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
    gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
    gsettings set org.gnome.desktop.wm.preferences auto-raise true
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
    gsettings set org.gnome.mutter attach-modal-dialogs false
    gsettings set org.gnome.mutter center-new-windows true
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 22.0
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
    gsettings set org.gnome.settings-daemon.plugins.media-keys screen-reader "[]"
    gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
    gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
    gsettings set org.gnome.shell app-picker-layout "[]"
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
    gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
    gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
    gsettings set org.gnome.shell.extensions.ding show-home false
    gsettings set org.gnome.shell.extensions.ding start-corner 'top-left'
    gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
    gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
    gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
    gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
    gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
    gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
    gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
    gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
    gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

    gnome-extensions disable ding@rastersoft.com
  fi
}

setup_extensions() {
  echo "Setup Extensions..."
  sudo apt-get install -y pipx
  pipx install gnome-extensions-cli --system-site-packages

  gnome-extensions install -f $EXTENSIONS_DIR/resource-monitor\@goransimic.zip
  gnome-extensions install -f $EXTENSIONS_DIR/window-mover\@goransimic.zip

  gext install current-monitor-window-app-switcher@thmatosbr
  gext install easy_docker_containers@red.software.systems
  gext install just-perfection-desktop@just-perfection

  sudo cp ~/.local/share/gnome-shell/extensions/current-monitor-window-app-switcher\@thmatosbr/schemas/org.gnome.shell.extensions.current-monitor-window-app-switcher.gschema.xml /usr/share/glib-2.0/schemas/
  sudo cp ~/.local/share/gnome-shell/extensions/easy_docker_containers\@red.software.systems/schemas/red.software.systems.easy_docker_containers.gschema.xml /usr/share/glib-2.0/schemas/
  sudo cp ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml /usr/share/glib-2.0/schemas/
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

  gsettings set red.software.systems.easy_docker_containers refresh-delay 3

  gsettings set org.gnome.shell.extensions.just-perfection animation 5
  gsettings set org.gnome.shell.extensions.just-perfection window-demands-attention-focus true
}

setup_gestures() {
  echo "Setup Gestures..."
  sudo apt-get install -y wmctrl xdotool libinput-tools
  git clone https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures
  cd /tmp/libinput-gestures
  sudo ./libinput-gestures-setup install
  sudo usermod -aG input $USER
  cd - > /dev/null
  rm -rf /tmp/libinput-gestures
  cp $CONFIGS_DIR/libinput-gestures/libinput-gestures.conf ~/.config/libinput-gestures.conf
  libinput-gestures-setup service autostart start
}

setup_zsh() {
  echo "Setup ZSH..."
  sudo apt-get install -y zsh
  chsh -s /bin/zsh
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
  cp $CONFIGS_DIR/zshrc ~/.zshrc
}

setup_zellij() {
  echo "Setup Zellij..."
  curl -sLo /tmp/zellij.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
  tar -xf /tmp/zellij.tar.gz -C /tmp zellij
  sudo install /tmp/zellij /usr/local/bin
  rm /tmp/zellij.tar.gz /tmp/zellij
  mkdir -p ~/.config/zellij
  cp $CONFIGS_DIR/zellij.kdl ~/.config/zellij/config.kdl
}

setup_docker() {
  echo "Setup Docker..."
  sudo curl -sLo /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker $USER
}

setup_mise() {
  echo "Setup Mise..."
  curl -s https://mise.run | sh
  mise use --global node@lts
  mise use --global yarn@latest
  mise use --global go@latest
}

setup_lazygit() {
  echo "Setup Lazygit..."
  LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz
  tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin
  rm /tmp/lazygit.tar.gz /tmp/lazygit
  mkdir -p ~/.local/share/{applications,icons}
  cp $ICONS_DIR/lazygit.png ~/.local/share/icons/lazygit.png
  cp $LAUNCHERS_DIR/lazygit.desktop ~/.local/share/applications/lazygit.desktop
  update-desktop-database ~/.local/share/applications
}

setup_lazydocker() {
  echo "Setup Lazydocker..."
  LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo /tmp/lazydocker.tar.gz https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz
  tar -xf /tmp/lazydocker.tar.gz -C /tmp lazydocker
  sudo install /tmp/lazydocker /usr/local/bin
  rm /tmp/lazydocker.tar.gz /tmp/lazydocker
  mkdir -p ~/.local/share/{applications,icons}
  cp $ICONS_DIR/lazydocker.png ~/.local/share/icons/lazydocker.png
  cp $LAUNCHERS_DIR/lazydocker.desktop ~/.local/share/applications/lazydocker.desktop
  update-desktop-database ~/.local/share/applications
}

setup_flameshot() {
  echo "Setup Flameshot..."
  sudo apt-get install -y flameshot
  mkdir -p ~/.config/flameshot
  cp $CONFIGS_DIR/flameshot.ini ~/.config/flameshot/flameshot.ini

  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Flameshot'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'sh -c -- "flameshot gui"'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>c'
}

setup_alacritty() {
  echo "Setup Alacritty..."
  sudo apt-get install -y alacritty
  mkdir -p ~/.config/alacritty
  cp $CONFIGS_DIR/alacritty.toml ~/.config/alacritty/alacritty.toml
}

setup_junction() {
  echo "Setup Junction..."
  sudo install $SCRIPTS_DIR/junction /usr/local/bin
  mkdir -p ~/.local/share/{applications,icons}
  cp $ICONS_DIR/junction.png ~/.local/share/icons/junction.png
  cp $LAUNCHERS_DIR/junction.desktop ~/.local/share/applications/junction.desktop
  cp $CONFIGS_DIR/mimeapps.list ~/.config/mimeapps.list
  update-desktop-database ~/.local/share/applications
}

setup_core() {
  setup_system
  [[ $RUNNING_GNOME ]] && setup_extensions
  [[ $RUNNING_GNOME ]] && setup_gestures
}

setup_cli() {
  setup_zsh
  setup_zellij
  setup_docker
  setup_mise
  setup_lazygit
  setup_lazydocker
}

setup_desktop() {
  setup_flameshot
  setup_alacritty
  setup_junction
}

setup_all() {
  setup_core
  setup_cli
  [[ $RUNNING_GNOME ]] && setup_desktop
}

update() {
  echo "Updating Ubuntu Setup..."
  git -C $ROOT_DIR pull
}

case $1 in
  "all") setup_all ;;
  "core") setup_core ;;
  "cli") setup_cli ;;
  "desktop") [[ $RUNNING_GNOME ]] && setup_desktop ;;
  "zsh") setup_zsh ;;
  "zellij") setup_zellij ;;
  "docker") setup_docker ;;
  "mise") setup_mise ;;
  "lazygit") setup_lazygit ;;
  "lazydocker") setup_lazydocker ;;
  "flameshot") [[ $RUNNING_GNOME ]] && setup_flameshot ;;
  "alacrity") [[ $RUNNING_GNOME ]] && setup_alacritty ;;
  "junction") [[ $RUNNING_GNOME ]] && setup_junction ;;
  "update") update ;;
esac
