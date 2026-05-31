#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
font_version="7.9"
font_name="MapleMono-NF-CN"
font_url="https://github.com/subframe7536/maple-font/releases/download/v${font_version}/${font_name}.zip"
font_checksum_url="${font_url}.sha256"
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

if [[ ! -f "$HOME/Library/Fonts/${font_name}-Regular.ttf" ]]; then
  curl -L --fail -o "$work_dir/${font_name}.zip" "$font_url"
  curl -L --fail -o "$work_dir/${font_name}.zip.sha256" "$font_checksum_url"
  (cd "$work_dir" && shasum -a 256 -c "${font_name}.zip.sha256")
  unzip -q "$work_dir/${font_name}.zip" -d "$work_dir/${font_name}"
  find "$work_dir/${font_name}" -name '*.ttf' -exec cp {} "$HOME/Library/Fonts/" \;
  atsutil databases -removeUser >/dev/null 2>&1 || true
  atsutil server -shutdown >/dev/null 2>&1 || true
  atsutil server -ping >/dev/null 2>&1 || true
fi

ln -sfn "$repo_dir" "$HOME/.config/wezterm"

if [[ -x /Applications/WezTerm.app/Contents/MacOS/wezterm ]]; then
  /Applications/WezTerm.app/Contents/MacOS/wezterm show-keys --lua >/dev/null
fi

echo "WezTerm config installed: $HOME/.config/wezterm -> $repo_dir"
