#!/usr/bin/env bash
set -eu

# $1 path to chart if one chart only
# $2 new version

chart=${1}
version=${2}

echo "chart "${chart}" is being updated to "${version}""

sed -i "s|^appVersion:.*|appVersion: \"${version}\"|g" ${chart}
