#!/usr/bin/sh

# return sha256sum for file
# $1 - filename
get_sha256sum() {
  sha256sum "$1" | head -c 64
}

# downloads a file
#  $1 - the file to download
#  $2 - the location to save the file
download_file() {
  curl -s -L "$1" >"$2"
}

# Downloads and verifies a file
#  $1 - the file to download
#  $2 - the location to save the file
#  $3 - the checksum of the file
# Note: if the file does not match the checksum, then
#  it is deleted.
download_with_checksum() {
  download_file "$1" "$2" && ( \
      [ "$(get_sha256sum "$2")" = "$3" ] \
      || ( rm -rf "$2" ; false ) )
}

WORK_DIR="$(mktemp -d)"

# check if tmp dir was created
if [ ! -d "$WORK_DIR" ]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
cleanup () {      
  # shellcheck disable=SC2317
  rm -rf "$WORK_DIR"
  # shellcheck disable=SC2317
  echo "Deleted temp working directory $WORK_DIR"
}
trap cleanup EXIT

die() {
  echo "A problem occured"
  exit 1
}

HACK_ZIP="$WORK_DIR/Hack.zip"
download_with_checksum \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip" \
  "$HACK_ZIP" \
  "f48f06d996adf19f60278c0a8d28ae1525b6caaa2719224ebc81e8db2f6d7de0" \
  || die
echo "Downloaded Hack font"

FA_ZIP="$WORK_DIR/fontawesome-free-6.5.1-desktop.zip"
download_with_checksum \
  "https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip" \
  "$FA_ZIP" \
  "88d13abdade8b24b5fbdf6fe7d3ee55507d2827be91990a066ed96b8a2a58003" \
  || die
echo "Downloaded Font Awesome"

mkdir -p "$HOME/.local/share/fonts" || die

unzip "$HACK_ZIP" -d "$HOME/.local/share/fonts/hack" || die
unzip "$FA_ZIP" -d "$HOME/.local/share/fonts/font-awesome" || ( fc-cache -fv ; die )

echo "Installed Fonts"

fc-cache -fv

exit 0
