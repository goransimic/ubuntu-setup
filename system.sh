setup_system() {
  echo "Setup System..."
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y curl fonts-firacode git
  sudo cp -v $CONFIGS_DIR/sysctl.conf /etc/sysctl/local.conf
  sudo sysctl -p
  cp -v $CONFIGS_DIR/bashrc ~/.bashrc
  cp -v $CONFIGS_DIR/inputrc ~/.inputrc
  cp -v $CONFIGS_DIR/aliases ~/.aliases

  if $IS_DESKTOP; then
    sudo apt-get install -y dconf-editor flatpak gnome-shell-extension-manager gnome-sushi gnome-tweaks
    sudo ln -s /var/lib/snapd/snap /snap
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
