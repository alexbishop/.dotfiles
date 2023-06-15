#!/usr/bin/sh

for f in foot lynx nvim sway tmux waybar ; do
  ln -s "`pwd`/$f" "~/.config/$f"
done

for f in .clang-format .clangd .dircolors ; do
  ln -s "`pwd`/misc/$f" "~/$f"
done
