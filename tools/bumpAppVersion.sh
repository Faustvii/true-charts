#!/usr/bin/env bash
set -eu

# $1 path to chart if one chart only
# $2 new version

type=${1}
chart=${2}
version=${3}

echo "chart "${type}" "${chart}" is being updated to "${version}""

if [ -d "${chart}" ]; then
    if [ -z "$version" ];
    then
        echo "empty version"
    else
        sed -i "s|^appVersion:.*|appVersion: \"${version}\"|g" ${chart}/Chart.yaml
        git add ${chart}/Chart.yaml
  fi
fi
