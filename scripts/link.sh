#!/bin/bash

set -e

CONFIG="symlinks.yaml"

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${BASEDIR}"

source ./config/zsh/.zshenv

eval "$(/opt/homebrew/bin/brew shellenv)"
dotbot -d "${BASEDIR}" -c "${CONFIG}" "${@}"

echo "Configuration applied successfully! Starting new shell..."
exec $SHELL
