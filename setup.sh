#!/bin/bash

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
CONFIGS_DIR=$ROOT_DIR/configs

IS_DESKTOP=$([[ $XDG_CURRENT_DESKTOP == *"GNOME"* ]] && echo true || echo false)

. $ROOT_DIR/system.sh
. $ROOT_DIR/cli.sh
. $ROOT_DIR/desktop.sh

setup_all() {
  setup_system
  setup_cli
  [[ $IS_DESKTOP ]] && setup_desktop
}

case $1 in
  "all") setup_all ;;
  "system") setup_system ;;
  "cli") setup_cli ;;
  "desktop") [[ $IS_DESKTOP ]] && setup_desktop ;;
  "zsh") setup_zsh ;;
  "zellij") setup_zellij ;;
  "docker") setup_docker ;;
  "mise") setup_mise ;;
  "lazygit") setup_lazygit ;;
  "lazydocker") setup_lazydocker ;;
  "extensions") [[ $IS_DESKTOP ]] && setup_extensions ;;
  "gestures") [[ $IS_DESKTOP ]] && setup_gestures ;;
  "flameshot") [[ $IS_DESKTOP ]] && setup_flameshot ;;
  "alacrity") [[ $IS_DESKTOP ]] && setup_alacrity ;;
esac
