#!/usr/bin/env bash

set -e           # exit on error
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # exit the script if any statement returns a non-true return value

REPO="https://raw.githubusercontent.com/darekkay/git-course/master"

echo "Creating required folders..."

mkdir -p "$HOME/bin"

echo "Backing up existing files..."

if [ -e "$HOME/.gitconfig" ]
  then cp "$HOME/.gitconfig" "$HOME/.gitconfig-$(date +%s).backup"
fi

echo "Downloading workshop files..."

curl -L -o "$HOME/bin/git-fake" "$REPO/home/bin/git-fake"

curl -L -o "$HOME/bin/git-exercise-commit-wrong-branch" "$REPO/home/bin/git-exercise-commit-wrong-branch"
curl -L -o "$HOME/bin/git-exercise-differences" "$REPO/home/bin/git-exercise-differences"
curl -L -o "$HOME/bin/git-exercise-merge-conflict" "$REPO/home/bin/git-exercise-merge-conflict"
curl -L -o "$HOME/bin/git-exercise-recap" "$REPO/home/bin/git-exercise-recap"
curl -L -o "$HOME/bin/git-exercise-stage-commit" "$REPO/home/bin/git-exercise-stage-commit"

chmod +x "$HOME/bin/git-fake"
chmod +x "$HOME/bin/git-exercise-commit-wrong-branch"
chmod +x "$HOME/bin/git-exercise-differences"
chmod +x "$HOME/bin/git-exercise-merge-conflict"
chmod +x "$HOME/bin/git-exercise-recap"
chmod +x "$HOME/bin/git-exercise-stage-commit"

echo "Configuring Git..."

git config --global init.defaultBranch main

git config --global pretty.custom "%Cred%h%Creset -%C(cyan)%d%Creset %s %C(green)(%cr) %Cblue<%an>%Creset"

git config --global alias.s "status -s"
git config --global alias.lg "log --graph --pretty=custom"
git config --global alias.lga "log --graph --pretty=custom --all"
git config --global alias.q "log --graph --pretty=custom --first-parent -20"
git config --global alias.amend "commit --amend --reuse-message=HEAD"
git config --global alias.ph "push -u origin HEAD"
git config --global alias.pf "push --force-with-lease"
git config --global alias.rb "!f() { git rebase -i HEAD~\"$1\"; }; f"
git config --global alias.fake "!\$HOME/bin/git-fake"

git config --global alias.ex-commit-branch "!\$HOME/bin/git-exercise-commit-wrong-branch"
git config --global alias.ex-differences "!\$HOME/bin/git-exercise-differences"
git config --global alias.ex-merge-conflict "!\$HOME/bin/git-exercise-merge-conflict"
git config --global alias.ex-stage-commit "!\$HOME/bin/git-exercise-stage-commit"
git config --global alias.ex-recap "!\$HOME/bin/git-exercise-recap"

echo "Git workshop setup finished."
