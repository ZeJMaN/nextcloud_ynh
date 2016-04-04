#
# Common variables
#

APPNAME="owncloud"

# ownCloud version
VERSION=9.0.0

# Package name for MediaGoblin dependencies
DEPS_PKG_NAME="owncloud-deps"

# Remote URL to fetch ownCloud tarball
OWNCLOUD_SOURCE_URL="https://download.owncloud.org/community/owncloud-${VERSION}.tar.bz2"

# Remote URL to fetch ownCloud tarball checksum
OWNCLOUD_SOUCE_SHA256="d16737510a77a81489f7c4d5e19b0756fa2ea1c5081ba174b0fec0f00da3a77c"

# App package root directory should be the parent folder
PKGDIR=$(cd ../; pwd)

#
# Common helpers
#

# Print a message to stderr and exit
# usage: die msg [retcode]
die() {
  printf "%s" "$1" 1>&2
  exit "${2:-1}"
}

# Download and extract ownCloud sources to the given directory
# usage: extract_owncloud DESTDIR [AS_USER]
extract_owncloud() {
  local DESTDIR=$1
  local AS_USER=${2:-admin}

  # retrieve and extract Roundcube tarball
  oc_tarball="/tmp/owncloud.tar.bz2"
  rm -f "$oc_tarball"
  wget -q -O "$oc_tarball" "$OWNCLOUD_SOURCE_URL" \
    || die "Unable to download ownCloud tarball"
  echo "$OWNCLOUD_SOUCE_SHA256 $oc_tarball" | sha256sum -c >/dev/null \
    || die "Invalid checksum of downloaded tarball"
  exec_as "$AS_USER" tar xjf "$oc_tarball" -C "$DESTDIR" --strip-components 1 \
    || die "Unable to extract ownCloud tarball"
  rm -f "$oc_tarball"
}

# Execute a command as another user
# usage: exec_as USER COMMAND [ARG ...]
exec_as() {
  local USER=$1
  shift 1

  if [[ $USER = $(whoami) ]]; then
    eval "$@"
  else
    # use sudo twice to be root and be allowed to use another user
    sudo sudo -u "$USER" "$@"
  fi
}

# Execute a command with occ as a given user from a given directory
# usage: exec_occ WORKDIR AS_USER COMMAND [ARG ...]
exec_occ() {
  local WORKDIR=$1
  local AS_USER=$2
  shift 2

  (cd "$WORKDIR" && exec_as "$AS_USER" \
      php occ --no-interaction --quiet --no-ansi "$@")
}