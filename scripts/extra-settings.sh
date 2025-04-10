#!/usr/bin/sh

# set neovim to the default git editor
git config --global core.editor "nvim"

# fix sage colors
mkdir -p ~/.sage
printf "%s" "%colors Linux" > ~/.sage/init.sage
