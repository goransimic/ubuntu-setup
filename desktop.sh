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
  git clone https://github.com/bulletmark/libinput-gestures.git /tmp/libinput-gestures
  cd /tmp/libinput-gestures
  sudo ./libinput-gestures-setup install
  sudo usermod -aG input $USER
  cd -
  rm -rf /tmp/libinput-gestures
  cp $CONFIGS_DIR/libinput-gestures/libinput-gestures.conf ~/.config/libinput-gestures.conf
  libinput-gestures-setup service autostart start
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

setup_desktop() {
  setup_extensions
  setup_gestures
  setup_flameshot
  setup_alacritty
}
