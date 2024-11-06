#!/bin/bash

set -ex

# This script sets up common git preferences that I like
# The global ~/.gitconfig can't easily be tracked in git
# because different email addresses are used with git
# on different machines

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

git config --global core.editor "subl -a -w"

git config --global push.autoSetupRemote true
git config --global push.default current
git config --global pull.ff only
