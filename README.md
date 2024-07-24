# Ubuntu Setup

Install and configure Ubuntu system

## Automatic Installation

### Install

```sh
curl -s https://raw.githubusercontent.com/goransimic/ubuntu-setup/master/install.sh | bash
```

### Usage

```sh
ubuntu-setup all|core|cli|desktop|system|extensions|gestures|zsh|zellij|docker|mise|lazygit|lazydocker|flameshot|alacritty
```

## Manual Installation

### System

```sh
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y curl fonts-firacode git
  sudo curl -sLo /etc/sysctl/local.conf https://github.com/goransimic/ubuntu-setup/tree/master/configs/sysctl.conf
  sudo sysctl -qp
  curl -sLo ~/.bashrc https://github.com/goransimic/ubuntu-setup/tree/master/configs/bashrc
  curl -sLo ~/.inputrc https://github.com/goransimic/ubuntu-setup/tree/master/configs/inputrc
  curl -sLo ~/.aliases https://github.com/goransimic/ubuntu-setup/tree/master/configs/aliases

  if [[ $XDG_CURRENT_DESKTOP == *"GNOME"* ]]; then
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
```

### Extensions

```sh
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
```

### Gestures

```sh
  sudo apt-get install -y wmctrl xdotool libinput-tools
  git clone -q https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures
  cd /tmp/libinput-gestures
  sudo ./libinput-gestures-setup install
  sudo usermod -aG input $USER
  cd - > /dev/null
  rm -rf /tmp/libinput-gestures
  curl -sLo ~/.config/libinput-gestures.conf https://github.com/goransimic/ubuntu-setup/tree/master/configs/libinput-gestures.conf
  libinput-gestures-setup service autostart start
```
