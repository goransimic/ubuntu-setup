#!/bin/bash

echo "Installing Ubuntu Setup..."
sudo apt-get update > /dev/null
sudo apt-get install -y git > /dev/null
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/{bin,share}/ubuntu-setup
git clone https://github.com/goransimic/ubuntu-setup.git $HOME/.local/share/ubuntu-setup
ln -sv $HOME/.local/share/ubuntu-setup/setup.sh $HOME/.local/bin/ubuntu-setup
