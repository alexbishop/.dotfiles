#!/usr/bin/sh

for f in foot lynx nvim sway tmux waybar kitty ; do
  if [ ! -e ~/.config/$f ]
  then
    ln -s "$(pwd)/$f" ~/.config/$f
  fi
done

for f in .clang-format .clangd .dircolors .bash_aliases ; do
  if [ ! -e ~/$f ]
  then
    ln -s "$(pwd)/misc/$f" ~/$f
  fi
done

VAR=$(cat << EOL
If present, consider changing the file

/usr/share/wayland-sessions/sway.desktop

to the following

[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=$(realpath ~)/.config/sway/sway
Type=Application
EOL
)
printf "%s\n" "$VAR"
