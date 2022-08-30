#!/usr/bin/env bash
set -eu

## Function details
# $1 - semver string
# $2 - level to incr {patch,minor,major} - patch by default
function incr_semver() {
    echo $1
    IFS='.' read -ra ver <<< "$1"
    [[ "${#ver[@]}" -ne 3 ]] && echo "Invalid semver string" && return 1
    [[ "$#" -eq 1 ]] && level='patch' || level=$2
    echo "hello"
    patch=${ver[2]}
    minor=${ver[1]}
    major=${ver[0]}
    echo "hello world\n"
    echo "$major.$minor.$patch"

    case $level in
        patch)
            patch=$((patch+1))
        ;;
        minor)
            patch=0
            minor=$((minor+1))
        ;;
        major)
            patch=0
            minor=0
            major=$((major+1))
        ;;
        *)
            echo "Invalid level passed"
            return 2
    esac
    echo "$major.$minor.$patch"
}

# $1 type
# $2 path to chart directory
# $3 new version

type=${1}
chart=${2}
version=${3}


echo "chart "${type}" "${chart}" is being updated to version '${version}'"

if [ -d "${chart}" ]; then
    if [ -z "$version" ];
    then
        echo "empty version"
    else
        version=${version/$'\r'}
        version=${version/$'\n'}
        version=$(incr_semver "${version}" "${type}")
        DIR="${chart%/*}"/"${version}"
        mv -v "$chart" "${DIR}"
        sed -i "s|^version:.*|version: ${version}|g" "${DIR}"/Chart.yaml
        cat "${DIR}"/Chart.yaml | grep "^appVersion:"
        cat "${DIR}"/Chart.yaml | grep "^version:"
  fi
fi
