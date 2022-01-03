#!/bin/bash

sudo apt install libsqlite3-dev

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

npm -v

npm install --global yarn

yarn -v

#npm uninstall -g yarn
