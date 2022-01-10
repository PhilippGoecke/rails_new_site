#!/bin/bash

set -euo pipefail
IFS=$'\n'

git init .

while IFS= read -r cmd; do
  echo "Command read: $cmd"
  $cmd

  git add .
  git commit -am "${cmd//\"/\\\"}"
done < <(curl -fsSL https://raw.githubusercontent.com/PhilippGoecke/rails_new_site/main/create.bash)
