#!/usr/bin/sh

PACKAGES=$(cat << EOL
bibtool
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
gimp
git
grim
inkscape
jq
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
tlp
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
