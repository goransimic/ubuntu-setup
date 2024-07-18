#!/bin/bash

sudo apt update > /dev/null
sudo apt install -y git > /dev/null

echo "Installing Ubuntu Setup..."
mkdir -p $HOME/.local/{bin,share}
rm -rf $HOME/.local/bin/ubuntu-setup
rm -rf $HOME/.local/share/ubuntu-setup
git clone https://github.com/goransimicdev/ubuntu-setup.git $HOME/.local/share/ubuntu-setup > /dev/null
ln -s $HOME/.local/share/ubuntu-setup/setup.sh $HOME/.local/bin/ubuntu-setup > /dev/null
