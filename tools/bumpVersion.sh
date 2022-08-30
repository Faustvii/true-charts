#!/usr/bin/env bash
# set -eu

# $1 type
# $2 path to chart directory
# $3 new version

type=${1}
chart=${2}
version=${3}

echo "chart "${type}" "${chart}" is being updated to version "${version}""

if [ -d "${chart}" ]; then
    if [ -z "$version" ];
    then
        echo "empty version"
    else
        sed -i "s|^version:.*|version: ${version}|g" ${chart}/Chart.yaml
        DIR=${chart%/*}
        mv $chart ${DIR}/${version}
  fi
fi
