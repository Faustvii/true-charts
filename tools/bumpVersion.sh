#!/usr/bin/env bash
# set -eu

# $1 type
# $2 path to chart directory
# $3 new version

type=${1}
chart=${2}
version=${3}

echo "chart "${type}" "${chart}" is being updated to app version "${version}""

if [ -d "${chart}" ]; then
    if [ -z "$version" ];
    then
        echo "empty version"
    else
        DIR=${chart%/*}/${version}
        mv -v $chart ${DIR}
        sed -i "s|^appVersion:.*|appVersion: \"${version}\"|g" ${DIR}/Chart.yaml
        sed -i "s|^version:.*|version: ${version}|g" ${DIR}/Chart.yaml
        cat ${DIR}/Chart.yaml | grep "^appVersion:"
        cat ${DIR}/Chart.yaml | grep "^version:"
  fi
fi
