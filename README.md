# Ubuntu Setup

Install and configure Ubuntu system

## Automatic Installation

### Install

```sh
curl -s https://raw.githubusercontent.com/goransimic/ubuntu-setup/master/install.sh | bash
```

### Update

```sh
ubuntu-setup update
```

### Usage

```sh
ubuntu-setup all|core|cli|desktop|system|extensions|gestures|zsh|zellij|docker|mise|lazygit|lazydocker|flameshot|alacritty|junction
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
fi
```

### Extensions

```sh
sudo apt-get install -y pipx
pipx install gnome-extensions-cli --system-site-packages

curl -sLo /tmp/resource-monitor\@goransimic.zip https://github.com/goransimic/ubuntu-setup/tree/master/extensions/resource-monitor\@goransimic.zip
gnome-extensions install -f /tmp/resource-monitor\@goransimic.zip
rm /tmp/resource-monitor\@goransimic.zip

curl -sLo /tmp/window-mover\@goransimic.zip https://github.com/goransimic/ubuntu-setup/tree/master/extensions/window-mover\@goransimic.zip
gnome-extensions install -f /tmp/window-mover\@goransimic.zip
rm /tmp/window-mover\@goransimic.zip

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

### ZSH

```sh
sudo apt-get install -y zsh
chsh -s /bin/zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
curl -sLo ~/.zshrc https://github.com/goransimic/ubuntu-setup/tree/master/configs/zshrc
```

### Zellij

```sh
curl -sLo /tmp/zellij.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xf /tmp/zellij.tar.gz -C /tmp zellij
sudo install /tmp/zellij /usr/local/bin
rm /tmp/zellij.tar.gz /tmp/zellij
mkdir -p ~/.config/zellij
curl -sLo ~/.config/zellij/config.kdl https://github.com/goransimic/ubuntu-setup/tree/master/configs/zellij.kdl
```

### Docker

```sh
sudo curl -sLo /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
```

### Mise

```sh
curl -s https://mise.run | sh
mise use --global node@lts
mise use --global yarn@latest
mise use --global go@latest
```

### Lazygit

```sh
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz
tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin
rm /tmp/lazygit.tar.gz /tmp/lazygit
mkdir -p ~/.local/share/{applications,icons}
curl -sLo ~/.local/share/icons/lazygit.png https://github.com/goransimic/ubuntu-setup/tree/master/icons/lazygit.png
curl -sLo ~/.local/share/applications/lazygit.desktop https://github.com/goransimic/ubuntu-setup/tree/master/launchers/lazygit.desktop
update-desktop-database ~/.local/share/applications
```

### Lazydocker

```sh
LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo /tmp/lazydocker.tar.gz https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz
tar -xf /tmp/lazydocker.tar.gz -C /tmp lazydocker
sudo install /tmp/lazydocker /usr/local/bin`
rm /tmp/lazydocker.tar.gz /tmp/lazydocker
mkdir -p ~/.local/share/{applications,icons}
curl -sLo ~/.local/share/icons/lazydocker.png https://github.com/goransimic/ubuntu-setup/tree/master/icons/lazydocker.png
curl -sLo ~/.local/share/applications/lazydocker.desktop https://github.com/goransimic/ubuntu-setup/tree/master/launchers/lazydocker.desktop
update-desktop-database ~/.local/share/applications
```

### Flameshot

```sh
sudo apt-get install -y flameshot
mkdir -p ~/.config/flameshot
curl -sLo ~/.config/flameshot/flameshot.ini https://github.com/goransimic/ubuntu-setup/tree/master/configs/flameshot.ini

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Flameshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'sh -c -- "flameshot gui"'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>c'
```

### Alacritty

```sh
sudo apt-get install -y alacritty
mkdir -p ~/.config/alacritty
curl -sLo ~/.config/alacritty/alacritty.toml https://github.com/goransimic/ubuntu-setup/tree/master/configs/alacritty.toml
```

### Cursor

```sh
CURSOR_URL=$(curl -s 'https://cursor.com/api/download?platform=linux-x64&releaseTrack=latest' | jq -r '.downloadUrl')
curl -sLo /tmp/cursor.appimage $CURSOR_URL
chmod +x /tmp/cursor.appimage
cd /tmp && ./cursor.appimage --appimage-extract && cd - > /dev/null
sudo rm -rf /opt/cursor
sudo mv /tmp/squashfs-root /opt/cursor
sudo chown -R root:root /opt/cursor
sudo chmod 4755 /opt/cursor/usr/share/cursor/chrome-sandbox
rm /tmp/cursor.appimage
mkdir -p ~/.local/share/applications
curl -sLo ~/.local/share/applications/cursor.desktop https://raw.githubusercontent.com/goransimic/ubuntu-setup/refs/heads/master/launchers/cursor.desktop
update-desktop-database ~/.local/share/applications
```

### Junction

```sh
curl -sLo /tmp/junction https://github.com/goransimic/ubuntu-setup/tree/master/scripts/junction
sudo install /tmp/junction /usr/local/bin
rm /tmp/junction
mkdir -p ~/.local/share/{applications,icons}
curl -sLo ~/.local/share/icons/junction.png https://github.com/goransimic/ubuntu-setup/tree/master/icons/junction.png
curl -sLo ~/.local/share/applications/junction.desktop https://github.com/goransimic/ubuntu-setup/tree/master/launchers/junction.desktop
curl -sLo ~/.config/mimeapps.list https://github.com/goransimic/ubuntu-setup/tree/master/configs/mimeapps.list
update-desktop-database ~/.local/share/applications
```
