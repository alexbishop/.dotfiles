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

die() {
  echo "A problem occured"
  exit 1
}

mkdir -p "$HOME/.local/bin" || die

download_with_checksum \
  "https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.appimage" \
  "$HOME/.local/bin/nvim" \
  "5f377dc48c49a4170bd698a80ef461a702b8ebb8b2f7ddbb776341503d36415f" \
  || die
chmod 755 "$HOME/.local/bin/nvim"

exit 0
