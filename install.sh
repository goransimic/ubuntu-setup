#!/bin/bash

echo "Installing Ubuntu Setup..."
sudo apt-get update > /dev/null
sudo apt-get install -y git > /dev/null
git clone https://github.com/goransimic/ubuntu-setup.git /tmp/ubuntu-setup
cd /tmp/ubuntu-setup
./setup.sh $1
cd - > /dev/null
rm -rf /tmp/ubuntu-setup
