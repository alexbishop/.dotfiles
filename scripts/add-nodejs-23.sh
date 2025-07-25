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
  "https://deb.nodesource.com/setup_23.x" \
  "$HOME/setup_23.x.sh" \
  "1644667c4aafc1fe70e9be22b4dd0e8c79b44de3acf89a9858582ace7a898bed" \
  || die
chmod 755 "$HOME/setup_23.x.sh"
cat "$HOME/setup_23.x.sh" 
rm -f "$HOME/setup_23.x.sh" 

exit 0
