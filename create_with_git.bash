#!/bin/bash

#set -e
set -u
set -o pipefail
IFS=$'\n'

git init
git add --all .
git commit -m "Initial commit"

set -f
while IFS= read -r cmd; do
  echo "Command read: $cmd"
  bash -c "$cmd"

  git add --all .
  git commit -am "${cmd//\"/\\\"}"
done < <(curl -fsSL https://raw.githubusercontent.com/PhilippGoecke/rails_new_site/main/create.bash)
set +f
