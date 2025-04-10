#!/usr/bin/sh

SCRIPT_INIT_DIR=$(pwd)

zigup default 0.13.0

die() {
  cd "$SCRIPT_INIT_DIR"
  echo "an error occured"
  exit 1
}

mkdir -p "$HOME/.local/opt" || die
cd "$HOME/.local/opt" || die

# download everything
git clone https://github.com/ghostty-org/ghostty || die
cd ghostty || die
git checkout v1.1.3 || die

# build ghostty
zig build -Doptimize=ReleaseFast || die

# add ghostty to your local bin, it needs to be run with `prefix` set as follows
mkdir -p "$HOME/.local/bin" || die
printf '#!/usr/bin/sh\nprefix="%s" "%s" $@' "$HOME/.local/opt/ghostty/zig-out" "$HOME/.local/opt/ghostty/zig-out/bin/ghostty" >"$HOME/.local/bin/ghostty"
chmod 755 "$HOME/.local/bin/ghostty"

cd "$SCRIPT_INIT_DIR"
exit 0
