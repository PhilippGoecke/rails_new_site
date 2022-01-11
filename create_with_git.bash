#!/bin/bash

#set -e
set -u
set -o pipefail
IFS=$'\n'

git init
sleep 1
git add --all .
git commit -m "Initial commit"

set -f
while IFS= read -r cmd; do
  echo "Command read: $cmd"
  bash -c "$cmd"

  wait

  git add --all .
  git commit -am "${cmd//\"/\\\"}"

  wait
  sleep 1
done < <(curl -fsSL https://raw.githubusercontent.com/PhilippGoecke/rails_new_site/main/create.bash)
set +f
