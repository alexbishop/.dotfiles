#!/usr/bin/sh

PACKAGES=$(cat << EOL
build-essential
clang-format
clang
cmake
curl
evince
ffmpeg
foot
gap
gedit
gh
git
inkscape
light
locate
luarocks
lynx
pcmanfm
pipewire
ripgrep
ruby-bundler
ruby-dev
ruby
sddm
shellcheck
sway
swayidle
swaylock
texlive-full
texstudio
tmux
vlc
waybar
wget
wl-clipboard
wofi
xdg-desktop-portal-wlr
xournalpp
xwayland
EOL
)

# shellcheck disable=SC2086
apt install $PACKAGES
