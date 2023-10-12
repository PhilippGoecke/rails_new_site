#!/bin/bash

sudo apt install libsqlite3-dev

sudo apt install libyaml-dev

#curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
KEYRING=/usr/share/keyrings/nodesource.gpg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | sudo tee "$KEYRING" >/dev/null
gpg --no-default-keyring --keyring "$KEYRING" --list-keys
DISTRO="$(lsb_release -s -c)"
echo "deb [signed-by=$KEYRING] https://deb.nodesource.com/node_16.x $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src [signed-by=$KEYRING] https://deb.nodesource.com/node_16.x $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs

npm -v

sudo npm install --global yarn

yarn -v

#npm uninstall -g yarn
