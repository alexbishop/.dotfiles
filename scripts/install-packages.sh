#!/usr/bin/sh

# Notice that gcc-multilib, libgtk-4-dev and libadwaita-1-dev are installed to build ghostty

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
fonts-hack-ttf
foot
gap
gcc-multilib
gedit
gh
gimp
git
grim
inkscape
jq
libgtk-4-dev
libadwaita-1-dev
light
locate
luarocks
lynx
nodejs
npm
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
vim
vlc
waybar
wget
wl-clipboard
wofi
xdg-desktop-portal-wlr
xdotool
xournalpp
xscreensaver
xwayland
yt-dlp
zathura
EOL
)

# shellcheck disable=SC2086
apt install $PACKAGES
npm install -g tree-sitter-cli
