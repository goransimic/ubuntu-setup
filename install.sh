#!/bin/bash

echo "Installing Ubuntu Setup..."
sudo apt-get update > /dev/null
sudo apt-get install -y git > /dev/null
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/share/ubuntu-setup
git clone https://github.com/goransimicdev/ubuntu-setup.git $HOME/.local/share/ubuntu-setup
ln -sf $HOME/.local/share/ubuntu-setup/setup.sh $HOME/.local/bin/ubuntu-setup
