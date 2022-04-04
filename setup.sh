#!/usr/bin/env bash

set -e           # exit on error
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # exit the script if any statement returns a non-true return value

REPO="https://raw.githubusercontent.com/darekkay/git-course/master"

echo "Creating required folders..."

mkdir -p "$HOME/bin"
mkdir -p "$HOME/.p4merge"
mkdir -p "$HOME/.ssh"

echo "Backing up existing files..."

if [ -e "$HOME/.gitconfig" ]
  then cp "$HOME/.gitconfig" "$HOME/.gitconfig-$(date +%s).backup"
fi

if [ -e "$HOME/.ssh/config" ]
  then cp "$HOME/.ssh/config" "$HOME/.ssh/config-$(date +%s).backup"
fi

echo "Downloading configuration files..."

curl -L -o "$HOME/.gitconfig" "$REPO/home/.gitconfig"
curl -L -o "$HOME/.p4merge/ApplicationSettings.xml" "$REPO/home/p4merge-settings"
curl -L -o "$HOME/bin/git-fake" "$REPO/home/bin/git-fake"
curl -L -o "$HOME/bin/git-exercise-merge-conflict" "$REPO/home/bin/git-exercise-merge-conflict"
curl -L -o "$HOME/bin/git-exercise-recap-day1" "$REPO/home/bin/git-exercise-recap-day1"
curl -L -o "$HOME/bin/git-exercise-stage-commit" "$REPO/home/bin/git-exercise-stage-commit"

chmod +x "$HOME/bin/git-fake"
chmod +x "$HOME/bin/git-exercise-merge-conflict"
chmod +x "$HOME/bin/git-exercise-recap-day1"
chmod +x "$HOME/bin/git-exercise-stage-commit"

echo "Generating SSH key..."

ssh-keygen -t rsa -b 4096 -N "" -C "git-jumpstart" -f ~/.ssh/git-jumpstart <<<y
printf "\n\nHost github.\x69\x62\x6d.com\n  IdentityFile ~/.ssh/git-jumpstart" >> ~/.ssh/config

echo "Verifying Notepad++ setup..."

if [ ! -f "C:/Program Files (x86)/Notepad++/notepad++.exe" ]; then
  echo "Notepad++ 32bit not found.";

  if [ -f "C:/Program Files/Notepad++/notepad++.exe" ]; then
    echo "Notepad++ 64bit found. Updating ~/.gitconfig...";
    sed -i "s/C:\/Program Files (x86)\/Notepad++/C:\/Program Files\/Notepad++/" "$HOME/.gitconfig"
  else
    echo "Notepad++ 64bit not found.";
  fi
fi
