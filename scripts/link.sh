#!/bin/bash

set -e

CONFIG="symlinks.yaml"

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${BASEDIR}"

source ./config/zsh/.zshenv

eval "$(/opt/homebrew/bin/brew shellenv)"
dotbot -d "${BASEDIR}" -c "${CONFIG}" "${@}"

cd "$HOME"
rm -rf .zshrc .zsh_sessions .zsh_history .*.pre-oh-my-zsh .zcompdump* .colima

cd "${BASEDIR}"
