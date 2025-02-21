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

die1() {
  echo "A problem occured"
  exit 1
}

temp_dir=$(mktemp -d) || die1

remove_temp() {
  rm -R "$temp_dir"
}

die() {
  echo "A problem occured"
  remove_temp
  exit 1
}

mkdir -p "$HOME/.local/bin" || die

download_with_checksum \
  "https://github.com/marler8997/zigup/releases/download/v2025_01_02/zigup-x86_64-linux.tar.gz" \
  "$temp_dir/zigup-x86_64-linux.tar.gz" \
  "1413d8369a34284bae39d17c9488634c89122181d831006bc1ea22f68e505522" \
  || die
tar -xf "$temp_dir/zigup-x86_64-linux.tar.gz" -C "$HOME/.local/bin" || die

chmod 755 "$HOME/.local/bin/zigup" || die

zigup fetch 0.13.0 || die
zigup default 0.13.0 || die
zigup keep 0.13.0 || die

remove_temp
exit 0

