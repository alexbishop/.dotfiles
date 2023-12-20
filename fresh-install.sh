#!/usr/bin/sh

./scripts/install-packages.sh
./scripts/install-fonts.sh
./scripts/install-nvim
./scripts/extra-settings.sh

./setup-configs.sh
