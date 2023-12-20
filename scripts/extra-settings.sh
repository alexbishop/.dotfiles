#!/usr/bin/sh

# set neovim to the default git editor
git config --global core.editor "nvim"

# fix sage colors
printf "%s" "%colors Linux" > ~/.sage/init.sage
