#!/usr/bin/sh

PACKAGES=$(cat << EOL
bibtool
build-essential
clang-format
clang
cmake
curl
evince
fd-find
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
nodejs
npm
pcmanfm
pipewire
python3-neovim
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
xdotool
xournalpp
xwayland
EOL
)

# shellcheck disable=SC2086
apt install $PACKAGES
npm install -g tree-sitter-cli
