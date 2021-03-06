#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh

  if [[ ${CI-} ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  fi

  download_artifact release-packages ./release-packages
  ./ci/release-container/build.sh
  ./ci/release-container/push.sh
}

main "$@"
