setup_zsh() {
  echo "Setup ZSH..."
  sudo apt-get install -y zsh
  chsh -s /bin/zsh
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
  cp -v $CONFIGS_DIR/zshrc ~/.zshrc
  cp -v $CONFIGS_DIR/aliases ~/.aliases
}

setup_zellij() {
  echo "Setup Zellij..."
  curl -Lo /tmp/zellij.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
  tar -xfv /tmp/zellij.tar.gz /tmp/zellij
  sudo install -v /tmp/zellij /usr/local/bin
  rm /tmp/zellij.tar.gz /tmp/zellij
  mkdir -p ~/.config/zellij
  cp -v $CONFIGS_DIR/zellij.kdl ~/.config/zellij/config.kdl
}

setup_docker() {
  echo "Setup Docker..."
  sudo apt-get install -y docker.io docker-buildx docker-compose-plugin
  sudo usermod -aG docker $USER
}

setup_mise() {
  echo "Setup Mise..."
  curl https://mise.run | sh
  mise use --global node@lts
  mise use --global go@latest
}

setup_lazygit() {
  echo "Setup Lazygit..."
  LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz
  tar -xfv /tmp/lazygit.tar.gz /tmp/lazygit
  sudo install -v /tmp/lazygit /usr/local/bin
  rm /tmp/lazygit.tar.gz /tmp/lazygit
}

setup_lazydocker() {
  echo "Setup Lazydocker..."
  LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo /tmp/lazydocker.tar.gz https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz
  tar -xfv /tmp/lazydocker.tar.gz /tmp/lazydocker
  sudo install -v /tmp/lazydocker /usr/local/bin
  rm /tmp/lazydocker.tar.gz /tmp/lazydocker
}

setup_cli() {
  setup_zsh
  setup_zellij
  setup_docker
  setup_mise
  setup_lazygit
  setup_lazydocker
}
