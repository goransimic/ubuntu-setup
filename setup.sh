#!/bin/bash

ROOT_DIR=$HOME/.local/share/ubuntu-setup
CONFIGS_DIR=$ROOT_DIR/configs

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
    gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
    gsettings set org.gnome.desktop.wm.preferences auto-raise true
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
    gsettings set org.gnome.mutter attach-modal-dialogs false
    gsettings set org.gnome.mutter center-new-windows true
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

    gnome-extensions disable ding@rastersoft.com
    gnome-extensions disable tiling-assistant@ubuntu.com
  fi
}

setup_extensions() {
  echo "Setup Extensions..."
  sudo apt-get install -y pipx
  pipx install gnome-extensions-cli --system-site-packages

  gext install just-perfection-desktop@just-perfection
  gext install Vitals@CoreCoding.com
  gext install ddterm@amezin.github.com
  gext install easy_docker_containers@red.software.systems

  sudo cp ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml /usr/share/glib-2.0/schemas/
  sudo cp ~/.local/share/gnome-shell/extensions/Vitals\@CoreCoding.com/schemas/org.gnome.shell.extensions.vitals.gschema.xml /usr/share/glib-2.0/schemas/
  sudo cp ~/.local/share/gnome-shell/extensions/ddterm\@amezin.github.com/schemas/com.github.amezin.ddterm.gschema.xml /usr/share/glib-2.0/schemas/
  sudo cp ~/.local/share/gnome-shell/extensions/easy_docker_containers\@red.software.systems/schemas/red.software.systems.easy_docker_containers.gschema.xml /usr/share/glib-2.0/schemas/
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

  gsettings set org.gnome.shell.extensions.just-perfection animation 5
  gsettings set org.gnome.shell.extensions.just-perfection window-demands-attention-focus true

  gsettings set org.gnome.shell.extensions.vitals hot-sensors "['_memory_usage_', '_processor_usage_', '_battery_rate_']"
  gsettings set org.gnome.shell.extensions.vitals show-battery true
  gsettings set org.gnome.shell.extensions.vitals show-fan false
  gsettings set org.gnome.shell.extensions.vitals show-storage false
  gsettings set org.gnome.shell.extensions.vitals show-system false
  gsettings set org.gnome.shell.extensions.vitals show-voltage false
  gsettings set org.gnome.shell.extensions.vitals update-time 3

  gsettings set com.github.amezin.ddterm background-color '#282A36'
  gsettings set com.github.amezin.ddterm bold-color '#6E46A4'
  gsettings set com.github.amezin.ddterm bold-color-same-as-fg false
  gsettings set com.github.amezin.ddterm custom-font 'Monospace 12'
  gsettings set com.github.amezin.ddterm ddterm-toggle-key "['<Super>grave']"
  gsettings set com.github.amezin.ddterm foreground-color '#F8F8F2'
  gsettings set com.github.amezin.ddterm palette "['#262626', '#E356A7', '#42E66C', '#E4F34A', '#9B6BDF', '#E64747', '#75D7EC', '#EFA554', '#7A7A7A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']"
  gsettings set com.github.amezin.ddterm panel-icon-type 'none'
  gsettings set com.github.amezin.ddterm scrollback-lines 8192
  gsettings set com.github.amezin.ddterm tab-policy 'automatic'
  gsettings set com.github.amezin.ddterm use-theme-colors false
  gsettings set com.github.amezin.ddterm window-above false
  gsettings set com.github.amezin.ddterm windows-size 0.5

  gsettings set red.software.systems.easy_docker_containers refresh-delay 3
}

setup_gestures() {
  echo "Setup Gestures..."
  sudo apt-get install -y wmctrl xdotool libinput-tools
  git clone -q https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures
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
  sudo apt-get install -y docker.io docker-buildx docker-compose-plugin
  sudo usermod -aG docker $USER
}

setup_mise() {
  echo "Setup Mise..."
  curl -s https://mise.run | sh
  mise use --global node@lts
  mise use --global go@latest
}

setup_lazygit() {
  echo "Setup Lazygit..."
  LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz
  tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin
  rm /tmp/lazygit.tar.gz /tmp/lazygit
}

setup_lazydocker() {
  echo "Setup Lazydocker..."
  LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo /tmp/lazydocker.tar.gz https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz
  tar -xf /tmp/lazydocker.tar.gz -C /tmp lazydocker
  sudo install /tmp/lazydocker /usr/local/bin
  rm /tmp/lazydocker.tar.gz /tmp/lazydocker
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
}

setup_all() {
  setup_core
  setup_cli
  [[ $RUNNING_GNOME ]] && setup_desktop
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
  "alacrity") [[ $RUNNING_GNOME ]] && setup_alacrity ;;
esac
