#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

function nodes() {
  :
}

case "${1}" in
  replace | soft-replace | run | suspend | resume | stop )
    if [[ -f .cluster.sh ]]; then
      . .cluster.sh
    fi

    for node in $(nodes); do
      [[ -d "${node}" ]] || continue
      (cd ${node} && time sudo ./${1}.sh)
    done
    ;;
  *)
    echo "no such subcommand: ${1}" >&2
    ;;
esac
