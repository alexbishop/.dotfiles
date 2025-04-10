#!/usr/bin/sh

PATH="$HOME/.config/bin:$PATH"

./scripts/install-fonts.sh
./scripts/install-nvim
./scripts/extra-settings.sh
./setup-configs.sh
./scripts/install-zig.sh
./scripts/install-ghostty.sh
