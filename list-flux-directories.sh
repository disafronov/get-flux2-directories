#!/usr/bin/env sh

die() {
  echo "${@}"
  exit 1
}

test -n "$(which find)" || die "No [find] found!"
test -n "$(which sed)" || die "No [sed] found!"

test -n "${1}" && ROOT_DIR="${1}/" || ROOT_DIR="./"
test -n "${2}" && FILE_CHECK="${2}" || FILE_CHECK="flux-system/gotk-components.yaml"

find "${ROOT_DIR}" -maxdepth 1 -type d | while read DIR
do
  test "${ROOT_DIR}" = "${DIR}" && continue
  test ! -h "${DIR}" && test -d "${DIR}" && test -s "${DIR}/${FILE_CHECK}" && echo "${DIR}" | sed 's|^\.\/||' | sed 's|\/\/|\/|g' | sed 's|\ |\\ |g'
done
