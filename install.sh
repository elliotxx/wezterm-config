#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
font_version="6.2"
font_url="https://github.com/tonsky/FiraCode/releases/download/${font_version}/Fira_Code_v${font_version}.zip"
work_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer currently supports macOS only." >&2
  exit 1
fi

mkdir -p "$HOME/Library/Fonts" "$HOME/.config"

if [[ ! -f "$HOME/Library/Fonts/FiraCode-Regular.ttf" ]]; then
  curl -L --fail -o "$work_dir/Fira_Code.zip" "$font_url"
  unzip -q "$work_dir/Fira_Code.zip" -d "$work_dir/Fira_Code"
  cp "$work_dir"/Fira_Code/ttf/*.ttf "$HOME/Library/Fonts/"
  atsutil databases -removeUser >/dev/null 2>&1 || true
  atsutil server -shutdown >/dev/null 2>&1 || true
  atsutil server -ping >/dev/null 2>&1 || true
fi

ln -sfn "$repo_dir" "$HOME/.config/wezterm"

if [[ -x /Applications/WezTerm.app/Contents/MacOS/wezterm ]]; then
  /Applications/WezTerm.app/Contents/MacOS/wezterm show-keys --lua >/dev/null
fi

echo "WezTerm config installed: $HOME/.config/wezterm -> $repo_dir"
