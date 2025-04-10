#!/usr/bin/sh

for f in foot lynx nvim sway tmux waybar zathura ; do
  if [ ! -e ~/.config/$f ]
  then
    ln -s "$(pwd)/$f" ~/.config/$f
  fi
done

for f in .clang-format .clangd .bash_aliases ; do
  if [ ! -e ~/$f ]
  then
    ln -s "$(pwd)/misc/$f" ~/$f
  fi
done

if [ ! -e ~/.local/bin/sway ]
then
  ln -s "$(pwd)/sway/sway" ~/.local/bin/sway
fi

