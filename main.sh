#!/bin/bash

set -euo pipefail

target="./main.yml"
rm "$target"
echo "# Derived from config" >>"$target"

# Copy artifactory and postgresql manifests into main.yml
copyManifestsToMainYaml() {
  echo "Installing Velero .."
  for file in $(find ./manifests -type f -name "*.yaml" | sort); do
    echo "add " $file
    cat "$file" >>"$target"
    echo " " >>"$target"
    echo "---" >>"$target"
  done
}

#  Jfrog Artifactory OSS Installation
  copyManifestsToMainYaml

